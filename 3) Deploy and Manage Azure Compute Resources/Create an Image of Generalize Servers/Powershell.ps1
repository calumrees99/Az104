## Once you have ran "sysprep" or "waagent" and backed up the virtual machine 
## you need to deallocate resourses by using the "Stop-AzVM" CMDLET
Stop-AzVM -ResourceGroupName "<resource group>" -Name "<virtual machine name>"  -Force

## The set the VM to Generalize
Set-AzVM -ResourceGroupName "<resource group>" -Name "<virtual machine name>"  -Generalize

## Create an image of the VM
## Store VM as a variable
$vm = Get-AzVM -ResourceGroupName "<resource group>" -Name "<generalized virtual machine>"
## Store Image as a variable
$image = New-AzImageConfig -SourceVirtualMachineId
    $vm.ID -Location "<virtual machine location>"
## Create the Image using the Variables stated above
New-AzImage -Image $image -ImageName "<image name>"  -ResourceGroupName "<resource group>"

##Create new VM using the image created
New-AzVm -ResourceGroupName "<resource group>" -Name "<new virtual machine name>" -ImageName "<image name>" -Location "<location of image>"