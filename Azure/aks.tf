resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "${var.prefix}-dns"
  sku_tier            = "Free"
  identity { type = "SystemAssigned" }
  default_node_pool {
    name                 = var.nodepool_name
    node_count           = var.node_count
    vm_size              = var.node_vm_size
    vnet_subnet_id       = azurerm_subnet.subnet_nodes.id
    orchestrator_version = var.kubernetes_version
  }
  network_profile {
    network_plugin     = "azure"
    network_policy     = "azure"
    dns_service_ip     = "10.0.0.10"
    service_cidr       = "10.0.0.0/16"
    docker_bridge_cidr = "172.17.0.1/16"
  }
  role_based_access_control_enabled = true
  lifecycle {
    ignore_changes = [ default_node_pool[0].node_count ]
  }
}
