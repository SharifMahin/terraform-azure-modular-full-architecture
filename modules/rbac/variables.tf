variable "scope" {
  type        = string
  description = "Scope for role assignment — resource group ID"
}

variable "role_definition_name" {
  type        = string
  description = "Azure built-in role name"
  default     = "Contributor"
}

variable "principal_id" {
  type        = string
  description = "Managed identity principal ID"
}