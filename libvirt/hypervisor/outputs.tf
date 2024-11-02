output "base_volume_id" {
  value       = libvirt_volume.base_volume.id
  description = "The base OS volume id"
}

output "network_id" {
  value       = libvirt_network.network.id
  description = "The VM network id"
}

output "vm_network_cidr" {
  value       = var.vm_network_cidr
  description = "The VM network CIDR"
}

output "datastore_id" {
  value       = libvirt_pool.datastore.id
  description = "The datastore id"
}

output "datastore_name" {
  value       = libvirt_pool.datastore.name
  description = "The datastore name"
}