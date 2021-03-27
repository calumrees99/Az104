##Powershell version
$PSVersionTable.PSVersion

##Azure cmdlets
Import-Module Az

##Connect to Azure account
connect-AzAccount -UseDeviceAuthentication

##Should show list of tenant ID and Subscriptions"
Get-AzSubscription

##selects the subscription you want to use
Select-Azsubscription -SubscriptionId '7f309e9b-b581-4814-bc85-5f1850e7205c'

##Shows Resources groups in table
Get-AzResourceGroup | Format-Table

##Creates new resource group
New-Azresourcegroup -name PowershellTestGroup -Location UKSouth

##Check new resouce group (ft - short version of Format-Table)
Get-AzResourceGroup | ft

##Create new VM
New-AzVm -ResourceGroupName PowershellTestGroup -Name PWSUkSVM1 -location UkSouth -image Win2016Datacenter

##view new VM
Get-AzVM

##store VM as variable
$VM = get-azVM -ResourceGroupName PowershellTestGroup -VMname PWSUkSVM1

##View available VM size
Get-azvmsize -ResourceGroupName PowershellTestGroup -vmname PWSUkSVM1

##Delete ResourceGroup
Remove-azresourcegroup -name PowershellTestGroup 