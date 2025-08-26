output "resource_group" { value = azurerm_resource_group.rg.name }
output "aks_name"       { value = azurerm_kubernetes_cluster.aks.name }
output "kube_config"    { value = azurerm_kubernetes_cluster.aks.kube_admin_config_raw, sensitive = true }
