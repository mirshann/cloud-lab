module "gitlab_vm" {
 source      = "../../modules/compute"
 vm_name     = "gitlab"
 vm_size     = "n1-standard-4" # GitLab recommends at least 4 vCPUs and 8GB memory
 image       = "ubuntu-22-04-lts"
 network_id  = module.network.network_id
 subnet_id   = module.network.subnet_id
 tags        = ["gitlab", "public-access"]
}


module "load_balancer" {
  source = "../../modules/load_balancer"

  lb_name  = "cloud-lab-lb"
  region   = "nyc3"
  droplets = [for d in module.compute.vm_ids : { id = d }]
}

module "dns" {
  source = "../../modules/dns"
  domain_name      = "git.bog.rocks"
  record_type      = "A"
  record_value     = module.gitlab_vm.public_ip
  ttl              = 3600
}

output "vm_size" {
  value = module.compute.vm_size
}

output "vm_ip" {
  value = module.compute.public_ip
}