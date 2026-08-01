output "vm_id" {
  value = azurerm_windows_virtual_machine.vm.id
}

output "vm_name" {
  value = azurerm_windows_virtual_machine.vm.name
}

output "public_ip" {
  value = azurerm_public_ip.pip.ip_address
}

output "private_ip" {
  value = azurerm_network_interface.nic.private_ip_address
}