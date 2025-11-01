variable "server_id" {
  description = "Unique identifier for the server instance"
  type        = string
}

variable "region" {
  description = "AWS region for resources"
  type        = string
}

variable "availability_zone" {
  description = "Availability Zone for the Lightsail instance"
  type        = string
}

variable "blueprint_id" {
  description = "Lightsail blueprint ID"
  type        = string
}

variable "bundle_id" {
  description = "Lightsail bundle ID"
  type        = string
}

variable "environment" {
  description = "Environment tag"
  type        = string
}

variable "instance_name" {
  description = "Name of the Lightsail instance"
  type        = string
}

variable "ssh_cidr_blocks" {
  description = "CIDR blocks for SSH access"
  type        = list(string)
}