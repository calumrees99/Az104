##create new resource for resources
az group create --name <destination resource group name> --location <location name>

## stores the resource as a variable
$yourResource=(az resource show --resource-group <resource group name> --name <resource name> --resource-type <resource type> --query id --output tsv)

## Move the resource to another resource group
az resource move --destination-group <destination resource group name> --ids $yourResource

##Return all the resources in your resource group to verify your resource moved.
az resource list --resource-group <destination resource group name> --query [].type --output tsv | uniq