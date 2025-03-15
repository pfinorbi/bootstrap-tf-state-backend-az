variable "subscription_id" {
  description = "Id of the Azure subscription"
  type        = string
}

variable "location" {
  description = "Azure region to deploy the resources"
  type        = string
  default     = "westeurope"
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "tfstate-rg"
}

variable "storage_account_name" {
  description = "Name of the storage account"
  type        = string
  default     = "tfstatesa"
}

variable "storage_container_name" {
  description = "Name of the storage container"
  type        = string
  default     = "tfstate"
}