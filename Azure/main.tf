terraform {
  required_version = ">= 1.5.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.110"
    }
  }
}
provider "azurerm" { features {} }
# For workshops we keep local state; for prod, configure an azurerm backend.
