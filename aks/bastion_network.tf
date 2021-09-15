# Create vnet
resource "azurerm_virtual_network" "bastion-vnet" {
  name                = "${var.vm_network_name}-vnet"
  address_space       = var.vm_network_ip_range
  location            = var.location
  resource_group_name = azurerm_resource_group.bastion-rg.name
}

# Create subnet
resource "azurerm_subnet" "bastion-subnet" {
  name                 = var.vm_subnet_name
  resource_group_name  = azurerm_resource_group.bastion-rg.name
  virtual_network_name = azurerm_virtual_network.bastion-vnet.name
  address_prefixes     = var.vm_subnet_address_prefixes
  enforce_private_link_endpoint_network_policies = true
}

# Create Network Security Group
resource "azurerm_network_security_group" "bastion-nsg" {
  name                = "${var.vm_nsg_name}-nsg"
  location            = var.location
  resource_group_name = azurerm_resource_group.bastion-rg.name
  tags = var.tags
}

# Create Network Security Rules
resource "azurerm_network_security_rule" "bastion-securityrules" {
  count                       = length(var.vm_custom_rules)
  name                        = lookup(var.vm_custom_rules[count.index], "name", "default_rule_name")
  priority                    = lookup(var.vm_custom_rules[count.index], "priority")
  direction                   = lookup(var.vm_custom_rules[count.index], "direction", "Any")
  access                      = lookup(var.vm_custom_rules[count.index], "access", "Allow")
  protocol                    = lookup(var.vm_custom_rules[count.index], "protocol", "*")
  source_port_ranges          = split(",", replace(  lookup(var.vm_custom_rules[count.index], "source_port_range", "*" )  ,  "*" , "0-65535" ) )
  destination_port_ranges     = split(",", replace(  lookup(var.vm_custom_rules[count.index], "destination_port_range", "*" )  ,  "*" , "0-65535" ) )
  source_address_prefix       = lookup(var.vm_custom_rules[count.index], "source_address_prefix", "*")
  destination_address_prefix  = lookup(var.vm_custom_rules[count.index], "destination_address_prefix", "*")
  description                 = lookup(var.vm_custom_rules[count.index], "description", "Security rule for ${lookup(var.vm_custom_rules[count.index], "name", "default_rule_name")}")
  resource_group_name         = azurerm_resource_group.bastion-rg.name
  network_security_group_name = azurerm_network_security_group.bastion-nsg.name
}

# Create network interface
resource "azurerm_network_interface" "bastion-nic" {
  name                            = "${var.vm_nic_name}-nic"
  location                        = var.location
  resource_group_name             = azurerm_resource_group.bastion-rg.name

  ip_configuration {
    name                          = var.vm_nic_ip_name
    subnet_id                     = azurerm_subnet.bastion-subnet.id
    private_ip_address_allocation = var.vm_nic_ip_private_ip_address_allocation
  }

  tags = var.tags
}

# Create Network Link to Kubernetes Private DNS Zone
resource "azurerm_private_dns_zone_virtual_network_link" "bastion-link" {
  name                  = "bastion-link"
  resource_group_name   = azurerm_kubernetes_cluster.aks.node_resource_group
  private_dns_zone_name = regex("[\\w\\-_]\\.(.*)", azurerm_kubernetes_cluster.aks.private_fqdn)[0]
  virtual_network_id    = azurerm_virtual_network.bastion-vnet.id

  tags = var.tags
}

# Get Monitorings AKS
data "azurerm_kubernetes_cluster" "monitoring-aks" {
  name                = var.aks_monitoring_name
  resource_group_name = var.aks_monitoring_rg
}

# Create Network Link to Kubernetes Private DNS Zone
resource "azurerm_private_dns_zone_virtual_network_link" "monitoring-aks-link" {
  name                  = "monitoring-aks-link"
  resource_group_name   = data.azurerm_kubernetes_cluster.monitoring-aks.node_resource_group
  private_dns_zone_name = regex("[\\w\\-_]\\.(.*)", data.azurerm_kubernetes_cluster.monitoring-aks.private_fqdn)[0]
  virtual_network_id    = azurerm_virtual_network.bastion-vnet.id

  tags = var.tags
}

# Create network peering to Nexus
resource "azurerm_virtual_network_peering" "bastion-to-nexus-peer" {
  name                         = "bastion-to-nexus-peer"
  resource_group_name          = azurerm_resource_group.bastion-rg.name
  virtual_network_name         = azurerm_virtual_network.bastion-vnet.name
  remote_virtual_network_id    = var.peering_bastion_to_nexus_vnet_id
  allow_virtual_network_access = true
  allow_gateway_transit        = true
}

resource "azurerm_virtual_network_peering" "nexus-to-bastion-peer" {
  name                         = "nexus-to-bastion-peer"
  resource_group_name          = var.peering_nexus_to_bastion_rg
  virtual_network_name         = var.peering_nexus_to_bastion_vnet_name
  remote_virtual_network_id    = azurerm_virtual_network.bastion-vnet.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  use_remote_gateways          = true
}