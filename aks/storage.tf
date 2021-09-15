resource "random_id" "random" {
  byte_length = 3
}

resource "azurerm_storage_account" "storageaccount" {
  name                     = "${replace(azurerm_resource_group.rg.name, "-", "")}${random_id.random.dec}"
  resource_group_name      = azurerm_kubernetes_cluster.aks.node_resource_group
  location                 = azurerm_kubernetes_cluster.aks.location
  account_tier             = var.sa_tier
  account_replication_type = var.sa_replica_type

  tags = var.tags
}
