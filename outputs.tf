output "resource_group_name" {
  value = module.resource_group.name
}

output "location" {
  value = module.resource_group.location
}

output "vnet_name" {
  value = module.network.vnet_name
}

output "vm_subnet_id" {
  value = module.network.vm_subnet_id
}

output "pe_subnet_id" {
  value = module.network.pe_subnet_id
}

output "nsg_id" {
  value = module.nsg.nsg_id
}

output "nsg_name" {
  value = module.nsg.nsg_name
}

output "storage_account_name" {
  value = module.storage_account.storage_account_name
}

output "storage_account_id" {
  value = module.storage_account.storage_account_id
}

output "primary_blob_endpoint" {
  value = module.storage_account.primary_blob_endpoint
}

output "private_endpoint_id" {
  value = module.private_endpoint.private_endpoint_id
}

output "private_ip_address" {
  value = module.private_endpoint.private_ip_address
}