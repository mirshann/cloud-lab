output "vm_ip" {
  value = digitalocean_droplet.vm.ipv4_address
}

output "vm_name" {
  value = digitalocean_droplet.vm.name
}

output "vm_ids" {
  value = [digitalocean_droplet.vm.id]
}

output "vm_size" {
  value = var.size
}

output "public_ip" {
  value = digitalocean_droplet.vm.ipv4_address
}
