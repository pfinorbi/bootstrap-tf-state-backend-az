terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.22.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

variable "subscription_id" {
  description = "Id of the Azure subscription"
  type        = string
}

resource "azurerm_resource_group" "network_rg" {
  name     = "network-rg"
  location = "westeurope"
}

resource "azurerm_virtual_network" "vnet" {
  name                = "sample-vnet"
  resource_group_name = azurerm_resource_group.network_rg.name
  location            = azurerm_resource_group.network_rg.location
  address_space       = ["10.0.0.0/8"]
}
