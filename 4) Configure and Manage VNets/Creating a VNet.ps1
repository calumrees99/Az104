## Connect to Azure
Connect-AzAccount -UseDeviceAuthentication

## Create a resource group
$Location="UKSouth" 
New-AzResourceGroup -Name vm-networks -Location $Location

## Create a Subnet and Virtual Network
$Subnet=New-AzVirtualNetworkSubnetConfig -Name default -AddressPrefix 10.0.0.0/24
 New-AzVirtualNetwork -Name myVnet -ResourceGroupName vm-networks -Location $Location -AddressPrefix 10.0.0.0/16 -Subnet $Subnet

## Create 2 Vms to go onto the newly created VNet
## 1st
New-AzVm `
 -ResourceGroupName "vm-networks" `
 -Name "dataProcStage1" `
 -VirtualNetworkName "myVnet" `
 -SubnetName "default" `
 -image "Win2016Datacenter" `
 -Size "Standard_B1s"

## Get the IP address of VM1
Get-AzPublicIpAddress -Name dataProcStage1
##51.140.142.135

## 2nd
New-AzVm `
 -ResourceGroupName "vm-networks" `
 -Name "dataProcStage2" `
 -VirtualNetworkName "myVnet" `
 -SubnetName "default" `
 -image "Win2016Datacenter" `
 -Size "Standard_B1s"

## Disassociate the public IP address that was created by default for the VM2
$nic = Get-AzNetworkInterface -Name dataProcStage2 -ResourceGroup vm-networks
$nic.IpConfigurations.publicipaddress.id = $null
Set-AzNetworkInterface -NetworkInterface $nic

## delete resource group
Remove-AzResourceGroup -name "vm-networks"

