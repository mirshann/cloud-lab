#!/bin/bash
# Fetch Terraform outputs
VPN_IP=$(terraform output -raw vpn_server_public_ip)
CLIENT_CONFIG=$(terraform output -raw client_config)

# Save configuration locally
echo "$CLIENT_CONFIG" > client-config.conf

# Display download instructions
echo "Client configuration uploaded securely."
echo "VPN IP address: $VPN_IP"