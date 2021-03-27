##Connect to Azure CLI
az login

##Create a new Resource Group
az group create --name CLItestgroup --location UKSouth

##Check Resource Group has been created
az group list

##Check Resource Group in table form
az group list --output table

##App service plan help
az appservice plan create --help

##Creating the appservice plan (this takes a minute)
az appservice plan create --name calumCLItestapp --resource-group CLItestgroup --location UKSouth --sku FREE

##See the appservice plan
az appservice plan list --output table

##Create a web app (This takes a minute)
az webapp create --name CalumCLIwebapp --resource-group CLItestgroup --plan calumCLItestapp

##Test the app has been created
az webapp list --output table

##Connect to new webapp
curl calumcliwebapp.azurewebsites.net

##Add code from a Github repository
az webapp deployment source config --name CalumCLIwebapp --resource-group CLItestgroup --repo-url "https://github.com/Azure-Samples/php-docs-hello-world" --branch master --manual-integration

##Delete resource group once done
az group delete --name CLItestgroup

##logs out of azure
az logout