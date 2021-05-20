##Connect to Azure CLI
az login

##Review built in roles CLI
az role definition list --name "Virtual Machine Contributor" --output json | jq '.[] | .permissions[0].actions'

##Review built in roles Powershell
Get-AzRoleDefinition -Name "Virtual Machine Contributor" | Select Actions | ConvertTo-Json

##Get the most current list of resource provider operations
Get-AzProviderOperation */virtualMachines/*

##
az account list  --output json | jq '.[] | .id, .name'

##Creates new custom role
New-AzRoleDefinition -InputFile "C:\Users\calum\Documents\AZ104\Git\Az104\Virtual Machine Operator.JSON"

##Updates custom role
Set-AzRoleDefinition -InputFile "<<path-to-json-file>>"

##List of custom roles
Get-AzRoleDefinition | ? {$_.IsCustom -eq $true} | FT Name, IsCustom

##Show custom role definition
Get-AzRoleDefinition "Virtual Machine Operator"

##Assign a custom role
$USER = $(az ad user list --display-name "Calum Rees" --query [0].userPrincipalName --output tsv)
echo $USER
az ad user list 
az role assignment create --assignee $USER --role "Virtual Machine Operator"

##Show who is assigned a role
Get-AzRoleAssignment -RoleDefinitionName "Virtual Machine Operator"

##Delete the role
Get-AzRoleDefinition "Virtual Machine Operator" | Remove-AzRoleDefinition

##Delte resource group
Remove-azresourcegroup TestPermissions
