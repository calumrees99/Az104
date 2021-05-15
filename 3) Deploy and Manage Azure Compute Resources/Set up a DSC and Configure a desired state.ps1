## Run in cloud shell, to create a user name and generate a random password
USERNAME=azureuser
PASSWORD=$(openssl rand -base64 32)

##Create a VM
az vm create --resource-group learn-c0e73a30-c904-4500-b54d-980fb5485ab5 --name myVM --image win2016datacenter --admin-username $USERNAME --admin-password $PASSWORD

##Open port 80
az vm open-port --port 80 --resource-group learn-c0e73a30-c904-4500-b54d-980fb5485ab5 --name myV

##Change Cloud shell to PowerShell
pwsh

##See the resources DSC resources
Get-DscResource | select Name,Module,Properties

##Open code editor and create a file named "MyDscConfiguration.ps1"
code $HOME/MyDscConfiguration.ps1

##Enter this code into the file, it installs IIS if it`s not already installed
Configuration MyDscConfiguration {
    Node "localhost" {
      WindowsFeature MyFeatureInstance {
        Ensure = 'Present'
        Name = 'Web-Server'
      }
    }
  }

##Upload the DSC script to Azure automation account
Import-AzureRmAutomationDscConfiguration -AutomationAccountName CSR-TestAutomation -ResourceGroupName learn-c0e73a30-c904-4500-b54d-980fb5485ab5 -SourcePath $HOME/MyDscConfiguration.ps1 -Force -Published

