variable "instance_name" {
  description = "Name of the Lightsail instance"
  type        = string
}

variable "ssh_cidr_blocks" {
  description = "CIDR blocks for SSH access"
  type        = list(string)
}