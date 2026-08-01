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

variable "admin_username" {
  type        = string
  description = "VM admin username"
  sensitive   = true
}

variable "admin_password" {
  type        = string
  description = "VM admin password"
  sensitive   = true
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}

variable "vm_subnet_id" {
  type        = string
  description = "Subnet ID for NIC"
}

variable "identity_id" {
  type        = string
  description = "Managed identity ID to attach to VM"
}

variable "tags" {
  type        = map(string)
  default     = {}
}