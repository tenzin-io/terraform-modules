output "network_cidr" {
  value = var.network_cidr
}

output "network_id" {
  value = libvirt_network.vpc_network.id
}