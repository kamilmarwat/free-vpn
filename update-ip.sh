#!/bin/bash

# Fetch the public IP address
IP_ADDRESS=$(curl -s ifconfig.me)

# Check if IP address was fetched successfully
if [ -z "$IP_ADDRESS" ]; then
  echo "Error: Could not fetch public IP address." >&2
  exit 1
fi

# Create or update the terraform.tfvars file
cat > terraform.tfvars << EOL
ssh_cidr_blocks = ["$IP_ADDRESS/32"]
EOL

echo "terraform.tfvars has been updated with your IP address: $IP_ADDRESS"
