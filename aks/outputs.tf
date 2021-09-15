output "host" {
  value = azurerm_kubernetes_cluster.aks.kube_config[0].host
}

output "dns_zone_name_servers" {
  value = azurerm_dns_zone.dns_zone.name_servers
}

output "bastion_private_ip" {
  description = "Bastion Virtual private IP"
  value       = azurerm_network_interface.bastion-nic.private_ip_address
}

output "node_resource_group" {
  description = "Kubernetes Node Pool Resource Group"
  value       = azurerm_kubernetes_cluster.aks.node_resource_group
}