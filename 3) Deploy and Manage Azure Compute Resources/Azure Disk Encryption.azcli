## Azure Powershell - Create new Azure Key Vault
New-AzKeyVault -Location <location> -ResourceGroupName <resource-group> -VaultName "myKeyVault" -EnabledForDiskEncryption

## Azure CLI - Create New Azure Key Vault
az keyvault create  --name "myKeyVault" --resource-group <resource-group> --location <location> --enabled-for-disk-encryption True

## Azure Powershell - Enable DiskEncryption Policy
Set-AzKeyVaultAccessPolicy -VaultName <keyvault-name> -ResourceGroupName <resource-group> -EnabledForDiskEncryption

## Azure CLI - Enable DiskEncryption Policy
az keyvault update --name <keyvault-name> --resource-group <resource-group> --enabled-for-disk-encryption "true"

## Azure Powershell - Start Disk Encryption
Set-AzVmDiskEncryptionExtension -ResourceGroupName <resource-group> -VMName <vm-name> -VolumeType [All | OS | Data]-DiskEncryptionKeyVaultId <keyVault.ResourceId> -DiskEncryptionKeyVaultUrl <keyVault.VaultUri> -

## Azure CLI - Start Disk Encryption
az vm encryption enable --resource-group <resource-group> --name <vm-name> --disk-encryption-keyvault <keyvault-name> --volume-type [all | os | data]

## Azure Powershell - Show Disk Encryption Status
Get-AzVmDiskEncryptionStatus  -ResourceGroupName <resource-group> -VMName <vm-name>

## Azure CLI - Show Disk Encryption Status
az vm encryption show --resource-group <resource-group> --name <vm-name>

## Azure Powershell - Decrypt Drive
Disable-AzVMDiskEncryption -ResourceGroupName <resource-group> -VMName <vm-name>

## Azure CLI - Decrypt Drive
az vm encryption disable --resource-group <resource-group> --name <vm-name>