variable "nsg_name" {
  type        = string
  description = "NSG name"
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
  description = "VM subnet ID to associate NSG"
}

variable "tags" {
  type        = map(string)
  default     = {}
}