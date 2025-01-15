output "dns_fqdn" {
  value = "${var.subdomain}.${var.domain_name}"
}
