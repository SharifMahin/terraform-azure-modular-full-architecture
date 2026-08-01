# ── Resource Group ──────────────────────
variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}

variable "location" {
  type        = string
  description = "Azure region"
  default     = "japaneast"
}

# ── Network ─────────────────────────────
variable "vnet_name" {
  type        = string
  description = "VNet name"
}

variable "address_space" {
  type        = list(string)
  description = "VNet address space"
}

variable "vm_subnet_name" {
  type        = string
  description = "Subnet name for VM"
}

variable "vm_subnet_prefixes" {
  type        = list(string)
  description = "Subnet address prefixes for VM"
}

variable "pe_subnet_name" {
  type        = string
  description = "Subnet name for Private Endpoint"
}

variable "pe_subnet_prefixes" {
  type        = list(string)
  description = "Subnet address prefixes for Private Endpoint"
}

# ── NSG ─────────────────────────────────
variable "nsg_name" {
  type        = string
  description = "NSG name"
}

# ── Storage Account ──────────────────────
variable "storage_account_name" {
  type        = string
  description = "Storage account name — globally unique, lowercase, max 24 chars"
}

variable "container_name" {
  type        = string
  description = "Blob container name"
}

# ── Private Endpoint ─────────────────────
variable "private_endpoint_name" {
  type        = string
  description = "Private endpoint name"
}

# ── Managed Identity ─────────────────────
variable "identity_name" {
  type        = string
  description = "Managed identity name"
}

# ── Key Vault ────────────────────────────
variable "key_vault_name" {
  type        = string
  description = "Key Vault name — globally unique, max 24 chars"
}

variable "vm_username_secret_name" {
  type        = string
  description = "Secret name for VM username"
}

variable "vm_username" {
  type        = string
  description = "VM admin username"
  sensitive   = true
}

variable "vm_password_secret_name" {
  type        = string
  description = "Secret name for VM password"
}

variable "vm_password" {
  type        = string
  description = "VM admin password"
  sensitive   = true
}

# ── RBAC ─────────────────────────────────
variable "role_definition_name" {
  type        = string
  description = "Azure built-in role name"
  default     = "Contributor"
}

# ── Windows VM ───────────────────────────
variable "public_ip_name" {
  type        = string
  description = "Public IP name"
}

variable "nic_name" {
  type        = string
  description = "Network interface name"
}

variable "vm_name" {
  type        = string
  description = "VM name — max 15 chars"
}

variable "vm_size" {
  type        = string
  description = "VM size"
  default     = "Standard_B2s"
}

# ── Tags ─────────────────────────────────
variable "tags" {
  type        = map(string)
  default     = {}
}