# Global Variables
variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
}

variable "tenant_id" {
  description = "Azure Tenant ID"
  type        = string
}

variable "resource_group_name" {
  description = "Azure Resource Group Name"
  type        = string
}

variable "location" {
  description = "Azure Location"
  type        = string
}

variable "location_extended" {
  description = "Azure Location Extended"
  type        = string
}

variable "client_id" {
  description = "Service Principal ID"
  type        = string
}

variable "client_secret" {
  description = "Service Principal password"
  type        = string
}

variable "tags" {
  description = "Resource tags"
  type        = map
}