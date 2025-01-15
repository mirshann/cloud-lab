variable "domain_name" {
  description = "The name of the preconfigured domain in DigitalOcean"
  type        = string
}

variable "subdomain" {
  description = "Subdomain to create"
  type        = string
}

variable "load_balancer_ip" {
  description = "IP address of the load balancer"
  type        = string
}