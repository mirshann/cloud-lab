variable "lb_name" {
  description = "Name of the Load Balancer"
  type        = string
}

variable "region" {
  description = "Region for the Load Balancer"
  type        = string
}

variable "droplets" {
  description = "List of Droplet IDs to attach to the load balancer"
  type        = list(object({ id = string }))
}