# Global variables
subscription_id                 = ""
tenant_id                       = ""
resource_group_name             = ""
location                        = "northeurope"
location_extended               = "North Europe"
tags                            = {
  key                = "value"
}

# DNS variables
dns_zone_rg                     = ""
dns_zone                        = ""

# AKS variables
aks_rbac_enabled                = true
aad_admin_group_ids             = [""]
aad_managed_enabled             = true
# oms_enabled                   = true
default_node_count              = 1
default_pool_size               = "Standard_DS3_v2"
default_auto_scaling_enabled    = true
default_auto_scaling_max_count  = 15
default_auto_scaling_min_count  = 1
default_auto_scaling_node_count = 4
default_pool_labels             =  {"scope": "tools"}
basic_node_count                = 1
basic_pool_size                 = "Standard_D8s_v3"
basic_mode                      = "User"
basic_auto_scaling_enabled      = true
basic_auto_scaling_max_count    = 60
basic_auto_scaling_min_count    = 1
basic_auto_scaling_node_count   = 24
basic_pool_taints               = ["scope=basic:NoSchedule"]
basic_pool_labels               = {"scope": "basic"}
dbs_node_count                = 1
dbs_pool_size                 = "Standard_E4ds_v4"
dbs_mode                      = "User"
dbs_auto_scaling_enabled      = true
dbs_auto_scaling_max_count    = 10
dbs_auto_scaling_min_count    = 1
dbs_auto_scaling_node_count   = 1
dbs_pool_taints               = ["scope=dbs:NoSchedule"]
dbs_pool_labels               = {"scope": "dbs"}
kubernetes_version              = "1.19.11"

# AKS Network variables
aks_vnet                        = ""
nodes_cidr                      = [""]
aks_network_policy              = "calico"
aks_dns_service_ip              = ""
aks_docker_bridge_cidr          = "172.17.0.1/16"
aks_pod_cidr                    = ""
aks_service_cidr                = ""
aks_load_balancer_sku           = "Standard"

# Bastion Virtual Machine variables
vm_resource_group_name = ""
vm_name = ""
vm_size = "Standard_B2s"
vm_disk_name = ""
vm_disk_caching = "ReadWrite"
vm_disk_managed_disk_type = "Standard_LRS"
vm_image_publisher = "Canonical"
vm_image_offer = "UbuntuServer"
vm_image_sku = "18.04-LTS"
vm_image_version = "latest"
vm_profile_admin_username = ""
vm_linux_disable_password_authentication = "true"

# Bastion Virtual Machine Network variables
vm_network_name = ""
vm_network_ip_range = [""]
vm_subnet_name = "bastion-subnet"
vm_subnet_address_prefixes = [""]
vm_nsg_name = "bastion"
vm_nic_name = "bastion"
vm_nic_ip_name = "bastion-ip"
vm_nic_ip_private_ip_address_allocation = "Dynamic"

# Nexus Virtual Network Peering variables
peering_bastion_to_nexus_vnet_id    = ""
peering_nexus_to_bastion_rg         = ""
peering_nexus_to_bastion_vnet_name  = ""

# VPN Subnet variables
vpn_subnet_address_prefixes = [""]

# VPN public IP variables
vpn_public_ip_name = "vpn-ip"
vpn_public_ip_allocation = "Static"
vpn_public_ip_sku = "Standard"

# VPN Gateway variables
vpn_gateway_name = "vpn-gateway"
vpn_gateway_sku = "VpnGw1"
vpn_gateway_generation = "Generation1"
vpn_gateway_ip_config_name = "vnetGatewayConfig"
vpn_gateway_ip_config_private_allocation = "Dynamic"
vpn_client_protocols = ["OpenVPN", "IkeV2"]
vpn_client_address_space = [""]
vpn_public_cert_data = ""

# AKS Monitoring variables
aks_monitoring_rg               = ""
aks_monitoring_name             = ""
aks_monitoring_vnet_name        = ""

#Storage variables
sa_tier         = "Standard"
sa_replica_type = "LRS"