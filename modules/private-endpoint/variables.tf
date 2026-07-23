variable "private_endpoint_name" {
  type        = string
  description = "Private endpoint name"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}

variable "pe_subnet_id" {
  type        = string
  description = "Subnet ID for private endpoint"
}

variable "vnet_id" {
  type        = string
  description = "VNet ID for DNS zone link"
}

variable "storage_account_id" {
  type        = string
  description = "Storage account ID to connect"
}

variable "storage_account_name" {
  type        = string
  description = "Storage account name for DNS A record"
}

variable "tags" {
  type        = map(string)
  default     = {}
}