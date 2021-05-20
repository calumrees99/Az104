## Setup variables needed
$subnetName = "AzureBastionSubnet"
$virtualNetwork = MyVirtualNetwork
$addressPrefix = "10.0.2.0/24"

## Create new subnet for Bastion
$subnet = New-AzVirtualNetworkSubnetConfig ` 
-Name $subnetName ` 
-AddressPrefix $addressPrefix `

## add the subnet to existing VNet
Add-AzVirtualNetworkSubnetConfig ` 
-Name $subnetName `
-VirtualNetwork $virtualNetwork `
-AddressPrefix $addressprefix

## Create a public IP address for Bastion
$publicip = New-AzPublicIpAddress `
-ResourceGroupName "myBastionRG" `
-name "myPublicIP" `
-location "westus2" `
-AllocationMethod Static `
-Sku Standard

## Create the Bastion resource in the subnet
$bastion = New-AzBastion `
-ResourceGroupName "myBastionRG" `
-Name "myBastion" `
-PublicIpAddress $publicip `
-VirtualNetwork $virtualNetworks