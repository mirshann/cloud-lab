variable "vm_name" {
  description = "Name of the VM (Droplet)"
  type        = string
}

variable "region" {
  description = "Region to deploy the VM"
  type        = string
  default     = "nyc3" # DigitalOcean North America region
}

variable "size" {
  description = "Size of the Droplet"
  type        = string
  default     = "s-1vcpu-1gb"
}

variable "image" {
  description = "Operating system image for the Droplet"
  type        = string
  default     = "ubuntu-20-04-x64"
}

variable "ssh_key_name" {
  description = "Name of the SSH key to access the Droplet"
  type        = string
}
