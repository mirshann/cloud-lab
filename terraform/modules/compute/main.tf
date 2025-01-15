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

  ssh_keys = [data.digitalocean_ssh_key.default.id]
}

data "digitalocean_ssh_key" "default" {
  name = var.ssh_key_name
}
