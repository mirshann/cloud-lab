resource "digitalocean_vpc" "sandbox_vpc" {
  name   = var.vpc_name
  region = var.region
}

resource "digitalocean_firewall" "vpn_firewall" {
  name = "vpn-firewall"

  inbound_rule {
    protocol         = "udp"
    port_range       = "51820"
    source_addresses = ["0.0.0.0/0"]
  }

  outbound_rule {
    protocol         = "all"
    port_range       = "all"
    destination_addresses = ["0.0.0.0/0"]
  }

  droplet_ids = var.vpn_droplet_ids
}

resource "digitalocean_firewall" "bastion_firewall" {
  name = "bastion-firewall"

  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = ["10.0.0.0/16"]  # Private network range
  }

  outbound_rule {
    protocol         = "all"
    port_range       = "all"
    destination_addresses = ["0.0.0.0/0"]
  }

  droplet_ids = var.bastion_droplet_ids
}
