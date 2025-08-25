provider "azurerm" {
  features {}
}

locals {
  cluster_name = "aksdemo"
  location     = "East US"
}

resource "azurerm_resource_group" "default" {
  name     = "${local.cluster_name}-rg"
  location = local.location
  tags = { environment = "Demo" }
}

# Minimal AKS (1 node) for lab speed. Uses service principal credentials provided via TF_VAR_appId/password.
resource "azurerm_kubernetes_cluster" "default" {
  name                = "${local.cluster_name}-aks"
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name
  dns_prefix          = local.cluster_name

  default_node_pool {
    name       = "system"
    node_count = 1
    vm_size    = "Standard_B2s"
  }

  # For the lab we demonstrate SP auth; in production prefer managed identity.
  service_principal {
    client_id     = var.appId
    client_secret = var.password
  }

  role_based_access_control_enabled = true

  network_profile {
    network_plugin     = "azure"
    load_balancer_sku  = "standard"
    network_policy     = "azure"
  }

  tags = { environment = "Demo" }
}
