module "cluster" {
  count           = var.vm_node_count
  source          = "git::https://github.com/tenzin-io/terraform-modules.git//libvirt/virtual-machine?ref=main"
  name            = "${var.cluster_name}-worker-${count.index}"
  datastore_name  = var.datastore_name
  base_volume_id  = var.base_volume_id
  network_id      = libvirt_network.vpc_network.id
  addresses       = [cidrhost(var.vpc_network_cidr, 10 + count.index)]
  cpu_count       = var.vm_cpu_count
  memory_size_mib = var.vm_memory_size_mib
  disk_size_mib   = var.vm_disk_size_mib
  data_disks      = var.vm_data_disks

  launch_script = templatefile("${path.module}/templates/cluster_script.sh", {
    filestore_host = module.filestore.hostname
  })

  depends_on = [module.filestore]
}

module "filestore" {
  source         = "git::https://github.com/tenzin-io/terraform-modules.git//libvirt/virtual-machine?ref=main"
  name           = "${var.cluster_name}-filestore"
  datastore_name = var.datastore_name
  base_volume_id = var.base_volume_id
  network_id     = libvirt_network.vpc_network.id
  addresses      = [cidrhost(var.vpc_network_cidr, 2)]

  cpu_count       = 2
  memory_size_mib = 16 * 1024 // gib
  disk_size_mib   = 64 * 1024 // gib
  data_disks = {
    "/dev/vdb" = {
      disk_size_mib = 128 * 1024 // gib
      fs_type       = "ext4"
      mount_path    = "/data"
    }
  }

  launch_script = templatefile("${path.module}/templates/filestore_script.sh", {
    filestore_clients = var.vpc_network_cidr
  })
}