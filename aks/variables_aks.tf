# AKS Variables
variable "oms_enabled" {
  description = "Enabled onboard Azure Monitor for containers."
  type        = bool
  default     = false
}

variable "aks_rbac_enabled" {
  description = "Is Role Based Access Control Enabled?"
  type        = bool
}

variable "aad_admin_group_ids" {
  description = "A list of Object IDs of Azure Active Directory Groups which should have Admin Role on the Cluster."
  type        = list
}

variable "aad_managed_enabled" {
  description = "Is the Azure Active Directory integration Managed, meaning that Azure will create/manage the Service Principal used for integration."
  type        = bool
}

variable "default_node_count" {
  description = "Number of nodes for Default Node Pool"
  type        = number
}

variable "default_pool_size" {
  description = "The size of each VM in the Default Node Pool"
  type        = string
}

variable default_auto_scaling_enabled {
  description = "Whether to enable auto-scale Default Node Pool"
  type        = bool

}

variable default_auto_scaling_max_count {
  description = "The maximum number of nodes which should exist within Default Node Pool"
  type        = number

}

variable default_auto_scaling_min_count {
  description = "The minimum number of nodes which should exist within Default Node Pool"
  type        = number

}

variable default_auto_scaling_node_count {
  description = "The initial number of nodes which should exist within Default Node Pool"
  type        = number

}

variable default_pool_labels {
  description = "Node labels for Default Node Pool"
  type        = map

}

variable "basic_node_count" {
  description = "Number of nodes for basic Node Pool"
  type        = number
}

variable "basic_pool_size" {
  description = "The size of each VM in the basic Node Pool"
  type        = string
}

variable "basic_mode" {
  description = "Should this Node Pool be used for System or User resources?"
  type        = string
}

variable basic_auto_scaling_enabled {
  description = "Whether to enable auto-scale basic Node Pool"
  type        = bool

}

variable basic_auto_scaling_max_count {
  description = "The maximum number of nodes which should exist within basic Node Pool"
  type        = number

}

variable basic_auto_scaling_min_count {
  description = "The minimum number of nodes which should exist within basic Node Pool"
  type        = number

}

variable basic_auto_scaling_node_count {
  description = "The initial number of nodes which should exist within basic Node Pool"
  type        = number

}

variable basic_pool_taints {
  description = "Node taints for basic Node Pool"
  type        = list

}

variable basic_pool_labels {
  description = "Node labels for basic Node Pool"
  type        = map

}

variable "dbs_node_count" {
  description = "Number of nodes for dbs Node Pool"
  type        = number
}

variable "dbs_pool_size" {
  description = "The size of each VM in the dbs Node Pool"
  type        = string
}

variable "dbs_mode" {
  description = "Should this Node Pool be used for System or User resources?"
  type        = string
}

variable dbs_auto_scaling_enabled {
  description = "Whether to enable auto-scale dbs Node Pool"
  type        = bool

}

variable dbs_auto_scaling_max_count {
  description = "The maximum number of nodes which should exist within dbs Node Pool"
  type        = number

}

variable dbs_auto_scaling_min_count {
  description = "The minimum number of nodes which should exist within dbs Node Pool"
  type        = number

}

variable dbs_auto_scaling_node_count {
  description = "The initial number of nodes which should exist within dbs Node Pool"
  type        = number

}

variable dbs_pool_taints {
  description = "Node taints for dbs Node Pool"
  type        = list

}

variable dbs_pool_labels {
  description = "Node labels for dbs Node Pool"
  type        = map

}

variable "kubernetes_version" {
  description = "Version of Kubernetes specified when creating the AKS managed cluster"
  type        = string
}

# DNS Variables
variable dns_zone_rg {
  description = "Azure DNS Zone Resource Group"
  type        = string
}

variable "dns_zone" {
  description = "Azure DNS Zone name"
  type        = string
}

# Network Variables
variable "aks_vnet" {
  description = "IP address range for the AKS Virtual Network"
  type        = string
}

variable "nodes_cidr" {
  description = "Subnet IP range for AKS nodes"
  type        = list
}

variable "aks_network_policy" {
  description = "Network Policy plugin"
  type        = string
}

variable "aks_dns_service_ip" {
  description = "IP address for the AKS DNS service"
  type        = string
}

variable "aks_docker_bridge_cidr" {
  description = "IP address range for the Docker Bridge network"
  type        = string
}

variable "aks_pod_cidr" {
  description = "IP address range for the AKS Pods"
  type        = string
}

variable "aks_service_cidr" {
  description = "IP address range for the AKS Services"
  type        = string
}

variable "aks_load_balancer_sku" {
  description = "AKS Loadbalancer SKU"
  type        = string
}

# Storage variables
variable "sa_tier" {
  description = "Storage Account tier"
  type = string
}

variable "sa_replica_type" {
  description = "Storage Account replication type"
  type = string
}