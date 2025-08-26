terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.50"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.24"
    }
  }
}
provider "aws" { region = var.region }
# For workshops we keep local state; for prod use S3+DynamoDB backend.
data "aws_availability_zones" "available" {}
