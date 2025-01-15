module "compute" {
  source      = "../../modules/compute"
  
  vm_name     = "cloud-lab-vm"
  region      = "nyc3"
  size        = "s-1vcpu-1gb"
  image       = "ubuntu-20-04-x64"
  ssh_key_name = "Evgeny PC Ubuntu"
}

module "load_balancer" {
  source = "../../modules/load_balancer"

  lb_name  = "cloud-lab-lb"
  region   = "nyc3"
  droplets = [for d in module.compute.vm_ids : { id = d }]
}

module "dns" {
  source = "../../modules/dns"

  domain_name      = "bog.rocks"
  subdomain        = "lab"
  load_balancer_ip = module.load_balancer.lb_ip
}

output "vm_size" {
  value = module.compute.vm_size
}

output "vm_ip" {
  value = module.compute.public_ip
}