terraform {
  
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.75.0"
    }
    # helm = {
    #   source = "hashicorp/helm"
    #   version = "~> 2.11.0"
    # }
  }
  required_version = "~> 1.3"
}
