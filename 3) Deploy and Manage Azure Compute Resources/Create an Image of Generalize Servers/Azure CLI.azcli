## Once you have ran "sysprep" or "waagent" and backed up the virtual machine 
## you need to deallocate resourses by using the "az vm deallocate" command
az vm deallocate --resource-group "<resource group>" --name "<virtual machine name>"

## The set the VM to Generalize
az vm generalize --resource-group "<resource group>" --name "<virtual machine name>"

## Create an image of the VM
az vm create --name MyVMFromImage --computer-name MyVMFromImage --image MyVMImage --admin-username azureuser

## Create VM using the new Image
az vm create  --resource-group "<resource group>" --name "<new virtual machine name>" --image "<image name>" --location "<location of image>"