variable "key_vault_name" {
  type        = string
  description = "Key Vault name — globally unique, max 24 chars"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}

variable "identity_principal_id" {
  type        = string
  description = "Managed identity principal ID for KV access policy"
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

variable "tags" {
  type        = map(string)
  default     = {}
}