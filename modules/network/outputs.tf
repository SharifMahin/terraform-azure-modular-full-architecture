output "vnet_id" {
  value = azurerm_virtual_network.vnet.id
}

output "vnet_name" {
  value = azurerm_virtual_network.vnet.name
}

output "vm_subnet_id" {
  value = azurerm_subnet.vm_subnet.id
}

output "vm_subnet_name" {
  value = azurerm_subnet.vm_subnet.name
}

output "pe_subnet_id" {
  value = azurerm_subnet.pe_subnet.id
}

output "pe_subnet_name" {
  value = azurerm_subnet.pe_subnet.name
}