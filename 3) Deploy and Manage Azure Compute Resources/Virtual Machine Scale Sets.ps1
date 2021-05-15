## Start the code editor in Cloud Shell
code cloud-init.yaml

## Add the following code to the file:
#cloud-config
package_upgrade: true
packages:
  - nginx
write_files:
  - owner: www-data:www-data
  - path: /var/www/html/index.html
    content: |
        Hello world from Virtual Machine Scale Set !
runcmd:
  - service nginx restart

  ##Create a Resource Group
  az group create --location uksouth --name scalesetrg

  ##Create a Linux Scale set, and include the custom code
  az vmss create --resource-group scalesetrg --name webServerScaleSet --vm-sku Standard_B1s --image UbuntuLTS --upgrade-policy-mode automatic --custom-data cloud-init.yaml --admin-username azureuser --generate-ssh-
  
  ##The load balancer is automatically created with the scale set.
  ##Add health probe to the load balancer
  az network lb probe create --lb-name webServerScaleSetLB --resource-group scalesetrg --name webServerHealth --port 80 --protocol Http --path /

  ##Configure the load balancer to route HTTP traffic to instances in the scale set
  az network lb rule create --resource-group scalesetrg --name webServerLoadBalancerRuleWeb --lb-name webServerScaleSetLB --probe-name webServerHealth  --backend-pool-name webServerScaleSetLBBEPool  --backend-port 80  --frontend-ip-name loadBalancerFrontEnd --frontend-port 80 --protocol tcp

  ##Manually configure the number of instances in the scaleset
  az vmss scale --name MyVMScaleSet --resource-group MyResourceGroup --new-capacity 6

  ##How to Install an application to an application to VMSS
  ##State the application in "yourConfigV1.json" file

  # yourConfigV1.json 
{
    "fileUris": ["https://raw.githubusercontent.com/yourrepo/master/custom_application_v1.sh"],
    "commandToExecute": "./custom_application_v1.sh"
  }

  ## Execute the installtion of the application using custom script
  az vmss extension set --publisher Microsoft.Azure.Extensions --version 2.0 --name CustomScript --resource-group myResourceGroup --vmss-name yourScaleSet --settings @yourConfigV1.json
 
  ##To update a scale set application
  ##State the application in "yourConfigV2.json" file
  
# yourConfigV2.json
{
    "fileUris": ["https://raw.githubusercontent.com/yourrepo/master/custom_application_v2.sh"],
    "commandToExecute": "./custom_application_v2.sh"
  }

  ## Execute the installtion of the application using custom script
  az vmss extension set --publisher Microsoft.Azure.Extensions --version 2.0 --name CustomScript --resource-group yourResourceGroup --vmss-name yourScaleSet --settings @yourConfigV2.json

  ##View the current Update policy of the VMSS
  az vmss show --name webServerScaleSet --resource-group scalesetrg --query upgradePolicy.mode
  
  ##Delete the Resource group
  az group delete -g scalesetrg
