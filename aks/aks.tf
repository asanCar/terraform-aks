### -> Forces recreation
# Create AKS cluster
resource "azurerm_kubernetes_cluster" "aks" {
  location            = var.location ###
  name                = azurerm_resource_group.rg.name ###
  resource_group_name = azurerm_resource_group.rg.name ###
  dns_prefix          = azurerm_resource_group.rg.name ###

  addon_profile {
    aci_connector_linux {
      enabled     = false
    }

    azure_policy {
      enabled = false
    }

    http_application_routing {
      enabled = false ###
    }

    kube_dashboard {
      enabled = false
    }

    oms_agent {
      enabled = false
    }
  }

  default_node_pool {
    name                  = "tools" ###
    vm_size               = var.default_pool_size
    availability_zones    = []
    enable_auto_scaling   = var.default_auto_scaling_enabled
    enable_node_public_ip = false
    max_count             = var.default_auto_scaling_max_count
    min_count             = var.default_auto_scaling_min_count
    # node_count            = var.default_auto_scaling_node_count
    # max_pods              = 110 ###
    node_taints           = []
    node_labels           = var.default_pool_labels ###
    orchestrator_version  = var.kubernetes_version
    # os_disk_size_gb       = 100 ###
    type                  = "VirtualMachineScaleSets"
    vnet_subnet_id        = azurerm_subnet.aks-subnet.id ###
  }

  kubernetes_version = var.kubernetes_version

  service_principal {
    client_id     = var.client_id
    client_secret = var.client_secret
  }

  # api_server_authorized_ip_ranges = []  # Azure Preview
  # enable_pod_security_policy = false    # Azure Preview
  private_cluster_enabled = true ###

  linux_profile {
    admin_username = "admin" ###

    ssh_key {
      key_data = file("${path.module}/data/vm_aks_key.pub") ###
    }
  }

  network_profile {
    network_plugin        = "kubenet" ###
    network_policy        = var.aks_network_policy ###
    dns_service_ip        = var.aks_dns_service_ip ###
    docker_bridge_cidr    = var.aks_docker_bridge_cidr ###
    pod_cidr              = var.aks_pod_cidr ###
    service_cidr          = var.aks_service_cidr ###
    load_balancer_sku     = var.aks_load_balancer_sku
    # load_balancer_profile {}
  }

  role_based_access_control {
    enabled = var.aks_rbac_enabled ###
    azure_active_directory {
      admin_group_object_ids = var.aad_admin_group_ids
      managed                = var.aad_managed_enabled ###
      tenant_id              = var.tenant_id
    }
  }

  tags = var.tags
}

resource "azurerm_kubernetes_cluster_node_pool" "basic" {
  name                  = "basic"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
  vm_size               = var.basic_pool_size
  mode                  = var.basic_mode
  availability_zones    = []
  enable_auto_scaling   = var.basic_auto_scaling_enabled
  enable_node_public_ip = false
  max_count             = var.basic_auto_scaling_max_count
  min_count             = var.basic_auto_scaling_min_count
  # node_count            = var.basic_auto_scaling_node_count
  # max_pods              = 110
  node_taints           = var.basic_pool_taints
  node_labels           = var.basic_pool_labels ###
  orchestrator_version  = var.kubernetes_version
  # os_disk_size_gb       = 100
  vnet_subnet_id        = azurerm_subnet.aks-subnet.id ###
}

resource "azurerm_kubernetes_cluster_node_pool" "dbs" {
  name                  = "dbs"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
  vm_size               = var.dbs_pool_size
  mode                  = var.dbs_mode
  availability_zones    = []
  enable_auto_scaling   = var.dbs_auto_scaling_enabled
  enable_node_public_ip = false
  max_count             = var.dbs_auto_scaling_max_count
  min_count             = var.dbs_auto_scaling_min_count
  # node_count            = var.dbs_auto_scaling_node_count
  # max_pods              = 110
  node_taints           = var.dbs_pool_taints
  node_labels           = var.dbs_pool_labels ###
  orchestrator_version  = var.kubernetes_version
  # os_disk_size_gb       = 100
  vnet_subnet_id        = azurerm_subnet.aks-subnet.id ###
}

