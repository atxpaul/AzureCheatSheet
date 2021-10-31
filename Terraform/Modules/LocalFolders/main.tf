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

#Create resource group
resource "azurerm_resource_group" "rg" {
  name     = "rg-myapp"
  location = "westus"
}

#Create Storage Account
module "storage_account1" {
  source = "./modules/storage-account"

  saname   = "statfdemosa24234"
  rgname   = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
}


#Create Storage Account
module "storage_account2" {
  source = "./modules/storage-account"

  saname   = "statfdemosa23434"
  rgname   = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
}


#Create virtual network
resource "azurerm_virtual_network" "vnet1" {
  name                = "vnet-dev-${azurerm_resource_group.rg.location}-001"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Create subnet
resource "azurerm_subnet" "subnet1" {
  name                 = "snet-dev-${azurerm_resource_group.rg.location}-001"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet1.name
  address_prefixes     = ["10.0.0.0/24"]
}

module "nsg" {
  source = "./modules/nsg"

  nsgname  = "appnsg"
  rgname   = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
}


resource "azurerm_subnet_network_security_group_association" "nsg_assoc" {
  subnet_id                 = azurerm_subnet.subnet1.id
  network_security_group_id = module.nsg.nsg_id
}
