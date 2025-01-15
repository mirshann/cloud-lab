module "compute" {
  source      = "../../modules/compute"
  
  vm_name     = "cloud-lab-vm"
  region      = "nyc3"
  size        = "s-1vcpu-1gb"
  image       = "ubuntu-20-04-x64"
  ssh_key_name = "Evgeny PC Ubuntu"
}

data "template_file" "ansible_inventory" {
  template = file("${path.module}/hosts.tpl")
  vars = {
    vm_ip = module.compute.public_ip
  }
}

resource "local_file" "ansible_inventory" {
  content  = data.template_file.ansible_inventory.rendered
  filename = "../../../ansible/inventories/development/hosts.yml"
}

resource "null_resource" "configure_web_server" {
  depends_on = [module.compute, local_file.ansible_inventory]

  provisioner "local-exec" {
    command = <<EOT
      ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook \
      -i ../../../ansible/inventories/development/hosts.yml \
      ../../../ansible/playbooks/webserver.yml
    EOT
  }
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