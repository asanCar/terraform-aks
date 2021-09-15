# Create AKS Virtual Network
resource "azurerm_virtual_network" "aks-vnet" {
  name                = "${azurerm_resource_group.rg.name}-vnet"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = [var.aks_vnet]
}

# Create AKS Virtual Subnetwork
resource "azurerm_subnet" "aks-subnet" {
  name                 = "nodes-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  address_prefixes     = var.nodes_cidr
  virtual_network_name = azurerm_virtual_network.aks-vnet.name
  enforce_private_link_service_network_policies = true
  enforce_private_link_endpoint_network_policies = true
}

# Create network peering to Bastion
resource "azurerm_virtual_network_peering" "aks-pro-to-bastion-peer" {
  name                         = "aks-pro-to-bastion-peer"
  resource_group_name          = azurerm_resource_group.rg.name
  virtual_network_name         = azurerm_virtual_network.aks-vnet.name
  remote_virtual_network_id    = azurerm_virtual_network.bastion-vnet.id
  allow_virtual_network_access = true
}

resource "azurerm_virtual_network_peering" "bastion-to-aks-pro-peer" {
  name                         = "bastion-to-aks-pro-peer"
  resource_group_name          = azurerm_resource_group.bastion-rg.name
  virtual_network_name         = azurerm_virtual_network.bastion-vnet.name
  remote_virtual_network_id    = azurerm_virtual_network.aks-vnet.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = false
}
