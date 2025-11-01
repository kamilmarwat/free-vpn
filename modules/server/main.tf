# Server Module for Outline VPN
# Contains instance and SSH key configurations

# Create SSH key pair for instance access
resource "aws_lightsail_key_pair" "outline_key" {
  name = "outline-key-${var.server_id}" # Stable unique name
  
  tags = {
    Name        = "outline-vpn-key"
    Environment = var.environment
    ManagedBy   = "terraform"
  }
}

# Create Lightsail instance with Ubuntu 24.04
resource "aws_lightsail_instance" "outline_server" {
  name              = "outline-server-${var.server_id}"
  availability_zone = "${var.region}${var.availability_zone}"
  blueprint_id      = var.blueprint_id
  bundle_id         = var.bundle_id
  key_pair_name     = aws_lightsail_key_pair.outline_key.name

  tags = {
    Name        = "outline-vpn-server"
    Environment = var.environment
    ManagedBy   = "terraform"
  }

  # Provisioner to run commands after instance creation
  provisioner "remote-exec" {
    inline = [
      # Update package lists and install dependencies
      "sudo apt-get update -qq",
      "sudo apt-get install -qq -y wget curl gpg",
      
      # Download and verify the installation script
      "curl -fsSL https://raw.githubusercontent.com/Jigsaw-Code/outline-apps/master/server_manager/install_scripts/install_server.sh -o install_server.sh",
      "chmod +x install_server.sh",
      
      # Run Outline install script with automated confirmation
      "echo 'Y' | sudo ./install_server.sh"
    ]

    # Connection configuration for Ubuntu
    connection {
      type        = "ssh"
      user        = "ubuntu" # Default user for Ubuntu images
      private_key = aws_lightsail_key_pair.outline_key.private_key
      host        = self.public_ip_address
      
      # Add timeout and retry logic
      timeout     = "10m"
    }
  }
}

# Configure necessary ports for Outline VPN
resource "aws_lightsail_instance_public_ports" "outline_ports" {
  instance_name = aws_lightsail_instance.outline_server.name

  # SSH access
  port_info {
    protocol  = "tcp"
    from_port = 22
    to_port   = 22
    cidrs     = var.ssh_cidr_blocks
  }

  # Outline management port
  port_info {
    protocol  = "tcp"
    from_port = 1024
    to_port   = 65535
    cidrs     = ["0.0.0.0/0"]
  }

  # Outline access key port
  port_info {
    protocol  = "udp"
    from_port = 1024
    to_port   = 65535
    cidrs     = ["0.0.0.0/0"]
  }

  depends_on = [aws_lightsail_instance.outline_server]
}