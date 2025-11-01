# Configure Terraform and required providers
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0" # Using newer AWS provider version
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

# Generate random ID for unique resource naming
resource "random_id" "server_id" {
  byte_length = 4
}

locals {
  instance_name = "outline-server-${random_id.server_id.hex}"
}

# Configure AWS provider with default region
provider "aws" {
  region = var.region
}

# VPC Module for networking configuration
module "vpc" {
  source        = "./modules/vpc"
  instance_name = local.instance_name
  ssh_cidr_blocks = var.ssh_cidr_blocks
}

# Server Module for Outline VPN instance
module "server" {
  source            = "./modules/server"
  server_id         = random_id.server_id.hex
  instance_name     = local.instance_name
  region            = var.region
  availability_zone = var.availability_zone
  blueprint_id      = var.blueprint_id
  bundle_id         = var.bundle_id
  environment       = var.environment
  ssh_cidr_blocks   = var.ssh_cidr_blocks
}

# Output the server's public IP address
output "public_ip" {
  value       = module.server.public_ip
  description = "The public IP address of the Outline VPN server"
}

# Output the generated private key (sensitive)
output "private_key" {
  value       = module.server.private_key
  sensitive   = true
  description = "The private SSH key for server access (sensitive)"
}

# Output important information
output "outline_server_info" {
  value       = module.server.server_details
  description = "General information about the Outline VPN server"
}