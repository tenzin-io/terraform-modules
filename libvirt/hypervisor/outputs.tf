output "base_volume_id" {
  value = libvirt_volume.base_volume.id
}

output "network_id" {
  value = libvirt_network.network.id
}

output "datastore_name" {
  value = libvirt_pool.datastore.name
}