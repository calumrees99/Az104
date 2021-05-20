##Connect to Azure CLI
az login

##Create Resource Group
az group create --name CLItestgroup --location UKSouth

##Create a storage account
az storage account create --name csrsharedfiles --resource-group CLItestgroup --sku Standard_GRS

## Get list of storage account keys
az storage account keys list --account-name csrsharedfiles

##Create a file share
az storage share create --account-name csrsharedfiles --account-key <accountkey> --name "name of file share"