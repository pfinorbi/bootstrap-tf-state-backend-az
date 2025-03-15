resource "local_file" "remote_backend" {
  content  = <<-BACKEND
  terraform {
    backend "azurerm" {
      resource_group_name  = "${azurerm_resource_group.tfstate_rg.name}"
      storage_account_name = "${azurerm_storage_account.tfstate_sa.name}"
      container_name       = "${azurerm_storage_container.tfstate_sc.name}"
      key                  = "tfstate-backend.terraform.tfstate"
      use_azuread_auth     = true
    }
  }
  BACKEND
  filename = "${path.module}/backend.tf"
  file_permission = "0666"
}