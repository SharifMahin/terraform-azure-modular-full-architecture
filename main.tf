module "resource_group" {
  source   = "./modules/resource-group"
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

module "network" {
  source              = "./modules/network"
  vnet_name           = var.vnet_name
  location            = module.resource_group.location  # .location → the name of the output defined in modules/resource-group/outputs.tf
  resource_group_name = module.resource_group.name      # flow = modules/resource-group/main.tf → modules/resource-group/outputs.tf → root/main.tf → modules/network/variables.tf → modules/network/main.tf → Azure
  address_space       = var.address_space
  vm_subnet_name      = var.vm_subnet_name
  vm_subnet_prefixes  = var.vm_subnet_prefixes
  pe_subnet_name      = var.pe_subnet_name
  pe_subnet_prefixes  = var.pe_subnet_prefixes
  tags                = var.tags
}

module "nsg" {
  source              = "./modules/nsg"
  nsg_name            = var.nsg_name
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
  vm_subnet_id        = module.network.vm_subnet_id
  tags                = var.tags
}

module "storage_account" {
  source               = "./modules/storage-account"
  storage_account_name = var.storage_account_name
  container_name       = var.container_name
  resource_group_name  = module.resource_group.name
  location             = module.resource_group.location
  tags                 = var.tags
}