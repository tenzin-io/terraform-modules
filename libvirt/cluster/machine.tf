module "cluster" {
  count           = var.vm_node_count
  source          = "git::https://github.com/tenzin-io/terraform-modules.git//libvirt/virtual-machine?ref=main"
  name            = "worker-${count.index}"
  datastore_name  = var.datastore_name
  base_volume_id  = var.base_volume_id
  network_id      = libvirt_network.vpc_network.id
  cpu_count       = 6
  memory_size_mib = 48 * 1024  // gib
  disk_size_mib   = 128 * 1024 // gib
  addresses       = [cidrhost(var.vpc_network_cidr, 10 + count.index)]
  data_disks = {
    "/dev/vdb" = {
      disk_size_mib = 350 * 1024 // gib
      fs_type       = "ext4"
      mount_path    = "/data"
    }
  }
}