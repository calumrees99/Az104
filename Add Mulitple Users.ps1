##Conect to Azure
connect-AzAccount -UseDeviceAuthentication

##Should show list of tenant ID and Subscriptions"
Get-AzSubscription

##selects the subscription you want to use
Select-Azsubscription -SubscriptionId '7f309e9b-b581-4814-bc85-5f1850e7205c'

##Connect to AzureAD Using the correct TenantID
Connect-AzureAD -tenantID 'fa97f9ac-d0b9-4704-a54e-46a12d33265b'

##Find out which tenantID your using
Get-AzureADTenantDetail

##Creating 1 User In Azure Active Directory:
# Create a password object
##$PasswordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
# Assign the password
##$PasswordProfile.Password = "Spongebob1999"
# Create the new user
##New-AzureADUser -AccountEnabled $True -DisplayName "Bob Brown" -PasswordProfile $PasswordProfile -MailNickName "BrownB" -UserPrincipalName "BrownB@calumrees99gmail.onmicrosoft.com"

##variable for the .csv information
$userlist = Import-Csv -Path "C:\Users\calum\Documents\AZ104\Test accounts\Test1-5.csv" 

##Creates the password object
$PasswordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
$PasswordProfile.Password = Spongebob12345

## The loop explained,
## $userlist basically declares that this is the information that will be looping through
## foreach-object{} - This runs once per row/array in the .csv file
## the $_.<namehere> refers to the column heading and the synax "$_." acts as a wildcard
## the information in the loop is the basic of how to create a new azure account
$userlist | foreach-object{new-AzureADUser -AccountEnabled $True -DisplayName $_.DisplayName -mailNickName $_.mailname -PasswordProfile $PasswordProfile -UserPrincipalName  $_.UserprincipalName -Department $_.Department}

##Creates a AzureADGroup
New-AzureADGroup -Description "Marketing" -DisplayName "Marketing" -MailEnabled $false -SecurityEnabled $true -MailNickName "Marketing"

##Get role definition
Get-AzRoleDefinition