terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

resource "digitalocean_loadbalancer" "lb" {
  name   = var.lb_name
  region = var.region

  forwarding_rule {
    entry_port     = 80
    entry_protocol = "http"
    target_port    = 80
    target_protocol = "http"
  }

  healthcheck {
    port     = 80
    protocol = "http"
    path     = "/"
  }

  droplet_ids = [for d in var.droplets : d.id]
}
