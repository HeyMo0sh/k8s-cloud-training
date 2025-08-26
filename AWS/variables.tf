variable "region" { description = "AWS region"; type = string; default = "ap-southeast-2" }
variable "prefix" { description = "Name prefix"; type = string; default = "eksdemo" }
variable "cluster_name" { description = "EKS cluster name"; type = string; default = "eks-cluster-002" }
variable "node_group_name" { description = "Node group"; type = string; default = "ng-apps001" }
variable "kubernetes_version" { description = "Kubernetes version (optional)"; type = string; default = "" }
variable "vpc_cidr" { description = "VPC CIDR"; type = string; default = "10.74.64.0/20" }
variable "public_subnet_cidrs" { description = "Public subnet CIDRs"; type = list(string); default = ["10.74.64.0/24","10.74.65.0/24"] }
variable "private_subnet_cidrs" { description = "Private subnet CIDRs"; type = list(string); default = ["10.74.80.0/24","10.74.81.0/24"] }
variable "node_instance_type" { description = "Worker node instance type"; type = string; default = "t3.large" }
variable "node_min" { type = number; default = 1 }
variable "node_desired" { type = number; default = 2 }
variable "node_max" { type = number; default = 3 }
