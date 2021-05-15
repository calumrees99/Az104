##Azure Powershell - Deploy a template from GitHub to a Resource Group
New-AzResourceGroupDeployment -Name encrypt-disk -ResourceGroupName <resource-group-name> -TemplateUri https://raw.githubusercontent.com/azure/azure-quickstart-templates/master/201-encrypt-running-windows-vm-without-aad/azuredeploy.json

##Azure CLI - Deploy a template from GitHub to a Resource Group
az group deployment create --resource-group <my-resource-group> --name <my-deployment-name> --template-uri https://raw.githubusercontent.com/azure/azure-quickstart-templates/master/201-encrypt-running-windows-vm-without-aad/azuredeploy.json