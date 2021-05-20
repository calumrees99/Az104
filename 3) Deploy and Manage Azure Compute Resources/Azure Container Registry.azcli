## Create an Azure Container Registry
az acr create --name csrukscontainer01 --resource-group ContainersTest --sku standard --admin-enabled true

## Download sample source code
git clone https://github.com/MicrosoftDocs/mslearn-deploy-run-container-app-service.git

## Run a docker image store in the Azure Container Registry
az acr build --file Dockerfile --registry csrukscontainer01 --image myimage .

## Create a C/I webapp
az acr task create --registry csrukscontainer01 --name buildwebapp --image webimage --context https://github.com/MicrosoftDocs/mslearn-deploy-run-container-app-service.git --file Dockerfile --git-access-token ""

##Move to source folder
cd mslearn-deploy-run-container-app-service/dotnet

##Update the webapp
##Go to the dotnet/SampleWeb/Pages folder. 
##This folder contains the source code for the HTML pages that are displayed by the web app.
cd ~/mslearn-deploy-run-container-app-service/dotnet/SampleWeb/Pages

## Replace the orginal index page with a new one
mv Index.cshtml Index.cshtml.old
mv Index.cshtml.new Index.cshtml.cs

##  rebuild the image for the web app
cd ~/mslearn-deploy-run-container-app-service/dotnet
az acr build --registry csrukscontainer01 --image myimage .