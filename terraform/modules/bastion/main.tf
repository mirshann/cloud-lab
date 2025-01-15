resource "digitalocean_droplet" "bastion_host" {
  name   = var.name
  region = var.region
  size   = var.size
  image  = "ubuntu-20-04-x64"
  vpc_id = var.vpc_id

  # Assign all SSH keys to the droplet
  ssh_keys = [
    for key in data.digitalocean_ssh_keys.all_keys.ssh_keys : key.id
  ]

  tags = ["bastion"]
}
