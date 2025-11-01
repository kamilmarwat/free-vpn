variable "region" {
  description = "AWS region for resources"
  type        = string
  default     = "eu-central-1"
}

variable "ssh_cidr_blocks" {
  description = "CIDR blocks for SSH access"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "blueprint_id" {
  description = "Lightsail blueprint ID"
  type        = string
  default     = "ubuntu_24_04"
}

variable "bundle_id" {
  description = "Lightsail bundle ID"
  type        = string
  default     = "nano_2_0"
}

variable "environment" {
  description = "Environment tag"
  type        = string
  default     = "production"
}

variable "availability_zone" {
  description = "Availability Zone for the Lightsail instance (e.g., 'a', 'b', 'c')"
  type        = string
  default     = "a"
}