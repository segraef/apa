$resourceGroupName = "apa12342-rg"
$diskName = "osDisk.496c25f2-4432-42f2-a41e-cb6eb7700ea5.vhd"
$storageType = "Premium_LRS"
$location = "australiaeast"
$diskSize = 128
$vhdUri = "https://<sa>.blob.core.windows.net/system/Microsoft.Compute/Images/images/packer-osDisk.496c25f2-4432-42f2-a41e-cb6eb7700ea5.vhd"

az disk create `
--resource-group $resourceGroupName `
--name $diskName `
--sku $storageType `
--location $location `
--size-gb $diskSize `
--source $vhdUri

az image create -g $resourceGroupName -n "$diskName-image" --os-type Linux --source $vhdUri
az vmss create `
  --name apa-ubuntu-2204 `
  --resource-group $resourceGroupName `
  --image "$diskName-image" `
  --vm-sku Standard_D2_v3 `
  --storage-sku StandardSSD_LRS `
  --authentication-type SSH `
  --instance-count 2 `
  --disable-overprovision `
  --upgrade-policy-mode manual `
  --single-placement-group false `
  --platform-fault-domain-count 1 `
  --load-balancer ''`
  --vnet-name vnet-release-agents `
  --vnet-address-prefix 10.1.1.0/24 `
  --subnet snet-release-agents `
  --subnet-address-prefix 10.1.1.0/24
