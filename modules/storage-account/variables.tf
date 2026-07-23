variable "storage_account_name" {
  type        = string
  description = "Storage account name — globally unique, lowercase, max 24 chars"
}

variable "container_name" {
  type        = string
  description = "Blob container name"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "tags" {
  type        = map(string)
  default     = {}
}