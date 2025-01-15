resource "digitalocean_droplet" "vpn_server" {
  name   = var.name
  region = var.region
  size   = var.size
  image  = "ubuntu-20-04-x64"
  vpc_id = var.vpc_id

  ssh_keys = var.ssh_keys

  # Configure WireGuard using user_data
  user_data = <<EOT
#!/bin/bash
# Install WireGuard
apt update
apt install -y wireguard iptables-persistent

# Configure WireGuard
cat > /etc/wireguard/wg0.conf <<EOF
[Interface]
PrivateKey = $(wg genkey | tee /etc/wireguard/server_private.key)
Address = 10.0.0.1/24
ListenPort = 51820
SaveConfig = true
PostUp = iptables -A FORWARD -i wg0 -j ACCEPT; iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
PostDown = iptables -D FORWARD -i wg0 -j ACCEPT; iptables -t nat -D POSTROUTING -o eth0 -j MASQUERADE

[Peer]
PublicKey = $(wg genkey | tee /etc/wireguard/client_public.key | wg pubkey)
AllowedIPs = 10.0.0.2/32
EOF

# Enable IP forwarding
echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf
sysctl -p

# Enable and start WireGuard
systemctl enable wg-quick@wg0
systemctl start wg-quick@wg0
EOT

  tags = ["vpn"]
}

resource "local_file" "client_config" {
  content = <<EOT
[Interface]
PrivateKey = ${file("${path.module}/client_private.key")}
Address = 10.0.0.2/32

[Peer]
PublicKey = ${file("${path.module}/server_public.key")}
Endpoint = ${digitalocean_droplet.vpn_server.ipv4_address}:51820
AllowedIPs = 0.0.0.0/0
EOT
  filename = "${path.module}/client-config.conf"
}

output "client_config" {
  value = file("${local_file.client_config.filename}")
}

output "vpn_server_public_ip" {
  value = digitalocean_droplet.vpn_server.ipv4_address
}