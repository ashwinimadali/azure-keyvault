# Create resource group
resource "azurerm_resource_group" "keyvault-rg" {
  name     = var.resource_group_name
  location = var.location
}

# Retrieve data
data "azurerm_client_config" "current" {}

# Create key vault
# Create key vault
resource "azurerm_key_vault" "keyvault" {
  name                       = var.keyvault_name
  location                   = var.location
  resource_group_name        = azurerm_resource_group.keyvault-rg.name  # Corrected reference
  enabled_for_disk_encryption = false
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days = 7
  purge_protection_enabled   = false
  sku_name                   = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id
    
    key_permissions = [
      "Get",
    ]

    secret_permissions = [
      "Set",
      "Get",
      "Delete",
      "Purge",
      "Recover"
    ]

    storage_permissions = [
      "Get",
    ]
  }
}


resource "azurerm_key_vault_secret" "db-pwd" {
  name         = var.secret_name
  value        = var.secret_value
  key_vault_id = azurerm_key_vault.keyvault.id
}