data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "kv" {
  name                       = var.key_vault_name
  location                   = var.location
  resource_group_name        = var.resource_group_name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "standard"
  purge_protection_enabled   = false  # Now manully can purge(permanent delete). But keep always true in Production
  soft_delete_retention_days = 7
  tags                       = var.tags

  # Give yourself access — otherwise, you won't be able to add the secret.
  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    secret_permissions = [
      "Get", "List", "Set", "Delete", "Purge"
    ]
  }

  # Grant secret read access to the Managed Identity."
  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = var.identity_principal_id

    secret_permissions = [
      "Get", "List"
    ]
  }
}

resource "azurerm_key_vault_secret" "vm_username" {
  name         = var.vm_username_secret_name
  value        = var.vm_username
  key_vault_id = azurerm_key_vault.kv.id
}

resource "azurerm_key_vault_secret" "vm_password" {
  name         = var.vm_password_secret_name
  value        = var.vm_password
  key_vault_id = azurerm_key_vault.kv.id
}