# Create VPN subnet
resource "azurerm_subnet" "vpn-subnet" {
  name                 = "GatewaySubnet"
  resource_group_name  = azurerm_resource_group.bastion-rg.name
  virtual_network_name = azurerm_virtual_network.bastion-vnet.name
  address_prefixes     = var.vpn_subnet_address_prefixes
}

# Create VPN public IPs
resource "azurerm_public_ip" "vpn-publicip" {
  name                         = var.vpn_public_ip_name
  location                     = var.location
  resource_group_name          = azurerm_resource_group.bastion-rg.name
  allocation_method            = var.vpn_public_ip_allocation
  sku                          = var.vpn_public_ip_sku
}

# Create VPN Gateway
resource "azurerm_virtual_network_gateway" "vpn-gateway" {
  name                = var.vpn_gateway_name
  location            = var.location
  resource_group_name = azurerm_resource_group.bastion-rg.name

  type     = "Vpn"
  vpn_type = "RouteBased"

  active_active = var.vpn_gateway_active_active
  enable_bgp    = var.vpn_gateway_bgp
  sku           = var.vpn_gateway_sku
  generation    = var.vpn_gateway_generation

  ip_configuration {
    name                          = var.vpn_gateway_ip_config_name
    public_ip_address_id          = azurerm_public_ip.vpn-publicip.id
    private_ip_address_allocation = var.vpn_gateway_ip_config_private_allocation
    subnet_id                     = azurerm_subnet.vpn-subnet.id
  }

  vpn_client_configuration {
    vpn_client_protocols = var.vpn_client_protocols
    address_space = var.vpn_client_address_space

    root_certificate {
      name = "CERT_NAME"

      public_cert_data = var.vpn_public_cert_data
    }
  }
}