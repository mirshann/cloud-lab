terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

data "digitalocean_domain" "existing_domain" {
  name = var.domain_name
}

resource "digitalocean_record" "subdomain" {
  domain = data.digitalocean_domain.existing_domain.name
  type   = "A"
  name   = var.subdomain
  value  = var.load_balancer_ip
  ttl    = 3600
}