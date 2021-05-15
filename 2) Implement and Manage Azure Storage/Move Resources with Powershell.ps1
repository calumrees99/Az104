connect-AzAccount -UseDeviceAuthentication

##Create new resource group
New-AzResourceGroup -Name "TestStorageMove" -Location UkSouth

##Store resource in a variable
$yourResource = Get-AzResource -ResourceGroupName msftlearn-production-learn-rg -ResourceName devmsftlearnuks

##Move the resource
Move-AzResource -DestinationResourceGroupName TestStorageMove -ResourceId $yourResource.ResourceId

##verify the resources have been moved
Get-AzResource -ResourceGroupName TestStorageMove | ft