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
    tls_passthrough = true
    entry_protocol = "https"
    entry_port     = 443
    target_protocol = "https"
    target_port    = 443
  }

  redirect_http_to_https = true

  droplet_ids = [for d in var.droplets : d.id]

  healthcheck {
    port     = 80
    protocol = "http"
    path     = "/"
  }
}


