## Create resource group
az group create --name learn-deploy-aci-rg --location eastus

## Generate Random Domain Name
DNS_NAME_LABEL=aci-demo-$RANDOM

## Start a container instance
az container create --resource-group learn-deploy-aci-rg --name mycontainer --image microsoft/aci-helloworld --ports 80 --dns-name-label $DNS_NAME_LABEL --location uksouth

## Check status of container
az container show --resource-group learn-deploy-aci-rg --name mycontainer --query "{FQDN:ipAddress.fqdn,ProvisioningState:provisioningState}" --out table

## Testing On-Failure restart policy
## Create container
az container create --resource-group learn-deploy-aci-rg --name mycontainer-restart-demo --image microsoft/aci-wordcount:latest --restart-policy OnFailure --location uksouth

## Verify container`s status
az container show --resource-group learn-deploy-aci-rg --name mycontainer-restart-demo --query containers[0].instanceView.currentState.state

## View the container`s logs
az container logs --resource-group learn-deploy-aci-rg --name mycontainer-restart-demo

## Set Environment Variables
## Store COSMOS DB name as a varible
COSMOS_DB_NAME=aci-cosmos-db-$RANDOM

## Create Azure COSMOS DB
COSMOS_DB_ENDPOINT=$(az cosmosdb create --resource-group learn-deploy-aci-rg --name $COSMOS_DB_NAME --query documentEndpoint --output tsv)

## Get COSMOS DB connection key and store in variable
COSMOS_DB_MASTERKEY=$(az cosmosdb keys list --resource-group learn-deploy-aci-rg --name $COSMOS_DB_NAME --query primaryMasterKey --output tsv)

## Deploy container with the COSMOS DB
az container create --resource-group learn-deploy-aci-rg --name aci-demo --image microsoft/azure-vote-front:cosmosdb --ip-address Public --location eastus --environment-variables COSMOS_DB_ENDPOINT=$COSMOS_DB_ENDPOINT COSMOS_DB_MASTERKEY=$COSMOS_DB_MASTERKEY

## Get containers IP address
az container show --resource-group learn-deploy-aci-rg --name aci-demo --query ipAddress.ip --output tsv

## Secure environment variables to hide sensitive information
## Start by viewing the container environment variables
az container show --resource-group learn-deploy-aci-rg --name aci-demo --query containers[0].environmentVariables

## use the --secure-environment-variables argument instead of the
## --environment-variables argument, to store hide sensitive information
az container create --resource-group learn-deploy-aci-rg --name aci-demo-secure --image microsoft/azure-vote-front:cosmosdb --ip-address Public --location eastus --secure-environment-variables COSMOS_DB_ENDPOINT=$COSMOS_DB_ENDPOINT COSMOS_DB_MASTERKEY=$COSMOS_DB_MASTERKEY

## Run the command to view the environment variables
az container show --resource-group learn-deploy-aci-rg --name aci-demo-secure --query containers[0].environmentVariables

## Azure Container Instances are stateless. If the container crashes or stops, all of its state is lost.
## To persist state beyond the lifetime of the container, you must mount a volume from an external store.
## The below instructions creates a file share that containers can mount to

## Store new storage account a variable
STORAGE_ACCOUNT_NAME=mystorageaccount$RANDOM

## Create the new storage account
az storage account create --resource-group learn-deploy-aci-rg --name $STORAGE_ACCOUNT_NAME --sku Standard_LRS --location eastus

## Store the stroage account connection key
export AZURE_STORAGE_CONNECTION_STRING=$(az storage account show-connection-string --resource-group learn-deploy-aci-rg --name $STORAGE_ACCOUNT_NAME --output tsv)

## Create a file share in the storage account
az storage share create --name aci-share-demo

## Get storage account key
STORAGE_KEY=$(az storage account keys list --resource-group learn-deploy-aci-rg --account-name $STORAGE_ACCOUNT_NAME --query "[0].value" --output tsv)

## Display storage account key
echo $STORAGE_KEY

## Deploy a container and mount file share
az container create --resource-group learn-deploy-aci-rg --name aci-demo-files --image microsoft/aci-hellofiles --location eastus --ports 80 --ip-address Public --azure-file-volume-account-name $STORAGE_ACCOUNT_NAME --azure-file-volume-account-key $STORAGE_KEY --azure-file-volume-share-name aci-share-demo --azure-file-volume-mount-path /aci/logs/

## Get the containers IP address to test by inputting text
az container show --resource-group learn-deploy-aci-rg --name aci-demo-files --query ipAddress.ip --output tsv

## Display files in the file share
az storage file list -s aci-share-demo -o table

## Download one of the file to the CloudShell session
az storage file download -s aci-share-demo -p <filename>

## Print the contents of the file
cat <filename>

## Troubleshooting containers
## Create container
az container create --resource-group learn-deploy-aci-rg --name mycontainer --image microsoft/sample-aks-helloworld --ports 80 --ip-address Public --location eastus

## Get container logs
az container logs --resource-group learn-deploy-aci-rg --name mycontainer

## Get container events, the az container attach command provides diagnostic information during container startup
az container attach --resource-group learn-deploy-aci-rg --name mycontainer

## Execute a command in the container
## This command starts an interactive session with the container
az container exec --resource-group learn-deploy-aci-rg --name mycontainer --exec-command /bin/sh

## run to view working contents fo the directory
ls

## run "exit" to leave the session
exit

## Store the container ID in a variable
CONTAINER_ID=$(az container show -resource-group learn-deploy-aci-rg --name mycontainer --query id --output tsv)

## Retrieve CPU metrics
az monitor metrics list --resource $CONTAINER_ID  --metric CPUUsage --output table

## Retrieve Memory metrics
az monitor metrics list --resource $CONTAINER_ID --metric MemoryUsage --output table

## Delete resource group!
az group delete -g learn-deploy-aci-rg

