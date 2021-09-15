# Bastion Virtual Machine variables
variable "vm_resource_group_name" {
  description = "Virtual Machine Azure Resource Group Name"
  type        = string
}

variable "vm_name" {
  description = "Name of the Virtual Machine"
  type        = string
}

variable "vm_size" {
  description = "Virtual Machine size (tier)"
  type        = string
}

variable "vm_disk_name" {
  description = "Name of the Virtual Machine OS Disk"
  type        = string
}

variable "vm_disk_caching" {
  description = "Caching requirements for the OS Disk"
  type        = string
}

variable "vm_disk_managed_disk_type" {
  description = "Type of Managed Disk"
  type        = string
}

variable "vm_image_publisher" {
  description = "Image publisher"
  type        = string
}

variable "vm_image_offer" {
  description = "Group of related images from the publisher"
  type        = string
}

variable "vm_image_sku" {
  description = "Instance of a Imagge Offer"
  type        = string
}

variable "vm_image_version" {
  description = "Image version"
  type        = string
}

variable "vm_profile_admin_username" {
  description = "Admin username"
  type        = string
}

variable "vm_linux_disable_password_authentication" {
  description = "Specifies whether password authentication should be disabled"
  type        = string
}

# Bastion Virtual Machine Network variables
variable "vm_network_name" {
  description = "Virtual Network name"
  type        = string
}

variable "vm_network_ip_range" {
  description = "Virtual Network IP range"
  type        = list
}

variable "vm_subnet_name" {
  description = "Subnet name"
  type        = string
}

variable "vm_subnet_address_prefixes" {
  description = "Address prefix to use for the subnet"
  type        = list
}

variable "vm_nsg_name" {
  description = "Network Security Group name"
  type        = string
}

variable "vm_nic_name" {
  description = "Network Interface name"
  type        = string
}

variable "vm_nic_ip_name" {
  description = "IP Configuration name"
  type        = string
}

variable "vm_nic_ip_private_ip_address_allocation" {
  description = "Allocation method used for the Private IP Address"
  type        = string
}

variable "vm_custom_rules" {
  description = "Security rules for the network security group"
  type        = list

  default = [
    # #SSH
    # {
    #   name                       = "SSH"
    #   priority                   = 1001
    #   direction                  = "Inbound"
    #   access                     = "Allow"
    #   protocol                   = "Tcp"
    #   source_port_range          = "*"
    #   destination_port_range     = "22"
    #   source_address_prefix      = "*"
    #   destination_address_prefix = "*"
    # }
  ]
}

# Nexus Virtual Network Peering variables
variable "peering_bastion_to_nexus_vnet_id" {
  description = "Nexus Virtual Network ID"
  type        = string
}

variable "peering_nexus_to_bastion_rg" {
  description = "Resource Group where is allocated Nexus"
  type        = string
}

variable "peering_nexus_to_bastion_vnet_name" {
  description = "Nexus Virtual Network name"
  type        = string
}

# AKS Monitoring variables
variable "aks_monitoring_rg" {
  description = "AKS Monitoring Resource Group"
  type        = string
}

variable "aks_monitoring_name" {
  description = "AKS Monitoring name"
  type        = string
}

variable "aks_monitoring_vnet_name" {
  description = "AKS Monitoring Virtual Network name"
  type        = string
}