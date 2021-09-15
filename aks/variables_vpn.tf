# VPN Subnet variables
variable "vpn_subnet_address_prefixes" {
  description = "Address prefix to use for the subnet"
  type        = list
}

# VPN public IP variables
variable "vpn_public_ip_name" {
  description = "VPN Public IP name"
  type        = string
}

variable "vpn_public_ip_allocation" {
  description = "Allocation method for public IP"
  type        = string
}

variable "vpn_public_ip_sku" {
  description = "Public IP SKU"
  type        = string
}

# VPN Gateway variables
variable "vpn_gateway_name" {
  description = "Gateway name"
  type        = string
}

variable "vpn_gateway_active_active" {
  description = "active-active Virtual Network Gateway"
  type        = bool
  default     = false
}

variable "vpn_gateway_bgp" {
  description = "Enable Border Gateway Protocol for this Virtual Network Gateway"
  type        = bool
  default     = false
}

variable "vpn_gateway_sku" {
  description = "Gateway SKU"
  type        = string
}

variable "vpn_gateway_generation" {
  description = "Generation of the Virtual Network Gateway"
  type        = string
}

variable "vpn_gateway_ip_config_name" {
  description = "IP configuration name for the Virtual Network Gateway"
  type        = string
}

variable "vpn_gateway_ip_config_private_allocation" {
  description = "Allocation method for the Gateway's private IP"
  type        = string
}

variable "vpn_client_protocols" {
  description = "List of VPN client protocols supported"
  type        = list
}

variable "vpn_client_address_space" {
  description = "List of clients address space"
  type        = list
}

variable "vpn_public_cert_data" {
  description = "The public certificate of the root certificate authority in Base-64 encoded X.509 format (PEM) without BEGIN END"
  type        = string
}
