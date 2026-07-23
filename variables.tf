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

# ── Tags ─────────────────────────────────
variable "tags" {
  type        = map(string)
  default     = {}
}