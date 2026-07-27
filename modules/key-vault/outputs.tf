output "key_vault_id" {
  value = azurerm_key_vault.kv.id
}

output "key_vault_name" {
  value = azurerm_key_vault.kv.name
}

output "key_vault_uri" {
  value = azurerm_key_vault.kv.vault_uri
}

output "vm_username" {
  value     = azurerm_key_vault_secret.vm_username.value
  sensitive = true
}

output "vm_password" {
  value     = azurerm_key_vault_secret.vm_password.value
  sensitive = true
}