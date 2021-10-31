application    = "terraexample"
location       = "westeurope"
admin_username = "atxadmin"
#admin_password     = "P@ssword!1234"
vnet_address_space = ["10.0.0.0/16"]
snet_address_space = ["10.0.0.0/24"]
vm_size            = "Standard_B1ls"
os = {
  publisher = "Canonical"
  offer     = "UbuntuServer"
  sku       = "18.04-LTS"
  version   = "latest"
}
