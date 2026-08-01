output "role_assignment_id" {
  value = azurerm_role_assignment.rbac.id
}

output "role" {
  value = azurerm_role_assignment.rbac.role_definition_name
}

output "scope" {
  value = azurerm_role_assignment.rbac.scope
}