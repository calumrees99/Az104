## Store Resource group as a variable
$location = (Get-AzResourceGroup -name learn-c8322cd2-0858-4dcc-a0c7-c5b3733dbd05).location

##Define more variables for Rg and VM name
$vmName = "fmdata-vm01"
$rgName = "learn-c8322cd2-0858-4dcc-a0c7-c5b3733dbd05"

##Store the VM as a variable
$vm = Get-AzVM -Name $vmName -ResourceGroupName $rgName

##View operating disk of the VM
$vm.StorageProfile.OSDisk

##Check the encryption status of the disk
Get-AzVmDiskEncryptionStatus  `
    -ResourceGroupName $rgName `
    -VMName $vmName

##Store Key vault name as a variable (The name must be GLOBALLY unique)
$keyVaultName = "mvmdsk-kv-1234"

##Create the new Key Vault
New-AzKeyVault -VaultName $keyVaultName `
    -Location $location `
    -ResourceGroupName $rgName `
    -EnabledForDiskEncryption

##Store key vault information as a variable
$keyVault = Get-AzKeyVault `
    -VaultName $keyVaultName `
    -ResourceGroupName $rgName

##Start the Encryption
Set-AzVmDiskEncryptionExtension `
	-ResourceGroupName $rgName `
    -VMName $vmName `
    -VolumeType All `
	-DiskEncryptionKeyVaultId $keyVault.ResourceId `
	-DiskEncryptionKeyVaultUrl $keyVault.VaultUri `
    -SkipVmBackup

##Check to see that the encryption is completed
Get-AzVmDiskEncryptionStatus  -ResourceGroupName $rgName -VMName $vmName
