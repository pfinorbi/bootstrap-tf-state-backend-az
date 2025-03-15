terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.22.0"
    }

    local = {
      source = "hashicorp/local"
      version = "2.5.2"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

provider "local" {}

data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "tfstate_rg" {
  name     = var.resource_group_name
  location = var.location
}