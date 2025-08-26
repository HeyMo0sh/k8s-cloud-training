variable "location" { description = "Azure region"; type = string; default = "australiaeast" }
variable "prefix"   { description = "Name prefix";   type = string; default = "aksdemo" }
variable "resource_group_name" { description = "Resource group name"; type = string; default = "rg-aksdemo" }
variable "vnet_address_space"  { description = "VNet CIDR"; type = string; default = "10.74.74.0/26" }
variable "subnet_address_prefix" { description = "Subnet CIDR"; type = string; default = "10.74.74.0/27" }
variable "aks_name"     { description = "AKS name"; type = string; default = "aks-cluster-002" }
variable "nodepool_name" { description = "Node pool name"; type = string; default = "npapps001" }
variable "node_vm_size" { description = "VM size"; type = string; default = "Standard_DS2_v2" }
variable "node_count"   { description = "Initial node count"; type = number; default = 2 }
variable "kubernetes_version" { description = "AKS version (optional)"; type = string; default = "" }
