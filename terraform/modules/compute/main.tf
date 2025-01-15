terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

resource "digitalocean_droplet" "vm" {
  name   = var.vm_name
  region = var.region
  size   = var.size
  image  = var.image

  # Assign all SSH keys to the droplet
  ssh_keys = [
    for key in data.digitalocean_ssh_keys.all_keys.ssh_keys : key.id
  ]

  tags = ["cloud-lab"]
}

# Fetch all SSH keys from DigitalOcean
data "digitalocean_ssh_keys" "all_keys" {}