resource "random_id" "tfstatesa_suffix" {
  byte_length = 6
}

resource "azurerm_storage_account" "tfstate_sa" {
  name                     = "${var.storage_account_name}${random_id.tfstatesa_suffix.dec}"
  resource_group_name      = azurerm_resource_group.tfstate_rg.name
  location                 = azurerm_resource_group.tfstate_rg.location
  account_kind             = "StorageV2"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "tfstate_sc" {
  name                  = var.storage_container_name
  storage_account_id    = azurerm_storage_account.tfstate_sa.id
  container_access_type = "private"
}

resource "azurerm_role_assignment" "tfstate_sa_ra" {
  scope                = azurerm_storage_account.tfstate_sa.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = data.azurerm_client_config.current.object_id
}