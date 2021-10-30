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

resource "azurerm_resource_group" "storage" {
  name     = "rg-terraformstate"
  location = "West Europe"
}

resource "azurerm_storage_account" "storage" {
  name                     = "atxterrastatestorage"
  resource_group_name      = azurerm_resource_group.storage.name
  location                 = azurerm_resource_group.storage.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "staging"
  }
  blob_properties {
    change_feed_enabled = true
    versioning_enabled  = true

  }
}

resource "azurerm_storage_container" "storage" {
  name                  = "terraformdemo"
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "private"


}
