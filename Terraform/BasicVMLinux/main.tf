terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.82.0"
    }
  }
}

#Azure provider
provider "azurerm" {
  features {}
}

#create resource group
resource "azurerm_resource_group" "rg" {
  name     = "rg-${var.application}"
  location = var.location
}

#Create virtual network
resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-${var.application}-${azurerm_resource_group.rg.location}-001"
  address_space       = var.vnet_address_space
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Create subnet
resource "azurerm_subnet" "subnet" {
  name                 = "snet-${var.application}-${azurerm_resource_group.rg.location}-001"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.snet_address_space
}

resource "azurerm_network_interface" "nic" {
  name                = "nic-${var.application}vm1-001 "
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "niccfg-${var.application}vm1"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "dynamic"
  }
}


resource "azurerm_linux_virtual_machine" "vm" {
  name                            = "vmterraform"
  location                        = azurerm_resource_group.rg.location
  resource_group_name             = azurerm_resource_group.rg.name
  network_interface_ids           = [azurerm_network_interface.nic.id]
  size                            = var.vm_size
  admin_username                  = var.admin_username
  admin_password                  = var.admin_password
  disable_password_authentication = false

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = lookup(var.storage_account_type, var.location, "Standard_LRS")
  }

  source_image_reference {
    publisher = var.os.publisher
    offer     = var.os.offer
    sku       = var.os.sku
    version   = var.os.version
  }

}
