variable "vnet_name" {
  type        = string
  description = "VNet name"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name"
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

variable "tags" {
  type        = map(string)
  default     = {}
}