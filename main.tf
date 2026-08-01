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

module "private_endpoint" {
  source                = "./modules/private-endpoint"
  private_endpoint_name = var.private_endpoint_name
  location              = module.resource_group.location
  resource_group_name   = module.resource_group.name
  pe_subnet_id          = module.network.pe_subnet_id
  vnet_id               = module.network.vnet_id
  storage_account_id    = module.storage_account.storage_account_id
  storage_account_name  = module.storage_account.storage_account_name
  tags                  = var.tags
}

module "managed_identity" {
  source              = "./modules/managed-identity"
  identity_name       = var.identity_name
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
  tags                = var.tags
}

module "key_vault" {
  source                  = "./modules/key-vault"
  key_vault_name          = var.key_vault_name
  location                = module.resource_group.location
  resource_group_name     = module.resource_group.name
  identity_principal_id   = module.managed_identity.principal_id
  vm_username_secret_name = var.vm_username_secret_name
  vm_username             = var.vm_username
  vm_password_secret_name = var.vm_password_secret_name
  vm_password             = var.vm_password
  tags                    = var.tags
}

module "rbac" {
  source               = "./modules/rbac"
  scope                = module.resource_group.id
  role_definition_name = var.role_definition_name
  principal_id         = module.managed_identity.principal_id
}

module "windows_vm" {
  source              = "./modules/windows-vm"
  public_ip_name      = var.public_ip_name
  nic_name            = var.nic_name
  vm_name             = var.vm_name
  vm_size             = var.vm_size
  admin_username      = module.key_vault.vm_username
  admin_password      = module.key_vault.vm_password
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
  vm_subnet_id        = module.network.vm_subnet_id
  identity_id         = module.managed_identity.identity_id
  tags                = var.tags
}