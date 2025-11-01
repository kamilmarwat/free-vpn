output "public_ip" {
  value       = aws_lightsail_instance.outline_server.public_ip_address
  description = "The public IP address of the Outline VPN server"
}

output "private_key" {
  value       = aws_lightsail_key_pair.outline_key.private_key
  sensitive   = true
  description = "The private SSH key for server access (sensitive)"
}

output "server_name" {
  value       = aws_lightsail_instance.outline_server.name
  description = "The name of the Outline VPN server"
}

output "server_details" {
  value = {
    server_name = aws_lightsail_instance.outline_server.name
    region      = var.region
    blueprint   = var.blueprint_id
  }
  description = "General information about the Outline VPN server"
} 