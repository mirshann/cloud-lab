module "network" {
  source  = "../../modules/network"
  vpc_name = "sandbox-vpc"
  region   = "nyc3"
}

module "vpn_server" {
  source  = "../../modules/vpn_server"
  name    = "vpn-gateway"
  region  = "nyc3"
  size    = "s-1vcpu-1gb"
  vpc_id  = module.network.vpc_id
  ssh_keys = ["your-ssh-key-name"]
}

module "bastion" {
  source  = "../../modules/bastion"
  name    = "bastion-host"
  region  = "nyc3"
  size    = "s-1vcpu-1gb"
  vpc_id  = module.network.vpc_id
  ssh_keys = ["your-ssh-key-name"]
}