resource "azurerm_resource_group" "dns_zone_rg" {
  name     = var.dns_zone_rg
  location = var.location_extended
}

resource "azurerm_dns_zone" "dns_zone" {
  name                = var.dns_zone
  resource_group_name = azurerm_resource_group.dns_zone_rg.name
  # zone_type           = "Public"
}