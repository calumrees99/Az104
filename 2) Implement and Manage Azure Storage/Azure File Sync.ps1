##Connect to Azure account
connect-AzAccount -UseDeviceAuthentication

##Variables
$resourcegroup = 'learn-file-sync-rg'
$location = 'UKSouth'

##Create Resource Group
New-AzResourceGroup -Name $resourcegroup -Location $location

##gets rid of warning
Set-Item Env:\SuppressAzurePowerShellBreakingChangeWarnings "true"

##Create subnet for new virtual network
$subnetConfig = New-AzVirtualNetworkSubnetConfig -Name Syncpublicnet -AddressPrefix 10.0.0.0/24

##Create virtual network
$virtualNetwork = New-AzVirtualNetwork -Name Syncvnet -AddressPrefix 10.0.0.0/16 -Location $location -ResourceGroupName $resourceGroup -Subnet $subnetConfig

##Virtual Machine Credentials
$cred = Get-Credential

##Create VM
New-Azvm `
 -Name FileServerLocal `
 -Credential $cred `
 -ResourceGroupName $resourceGroup `
 -Size Standard_B1ms `
 -VirtualNetworkName Syncvnet `
 -SubnetName Syncpublicnet `
 -Image "MicrosoftWindowsServer:WindowsServer:2019-Datacenter-with-Containers:latest"

 ##Delete resource group
 Remove-AzResourceGroup $resourceGroup