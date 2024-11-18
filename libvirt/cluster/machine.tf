locals {
  control_plane_resources = {
    cpu_count       = 2
    memory_size_mib = 4 * 1024  // gib
    disk_size_mib   = 30 * 1024 // gib
  }

  cluster_launch_script_inputs = {
    # kubernetes setup
    vpc_domain_name          = var.vpc_domain_name
    alternative_domain_names = var.alternative_domain_names

    cluster_api_listen_port  = 8001
    cluster_virtual_hostname = "${var.cluster_name}-control"
    cluster_virtual_ip       = cidrhost(var.vpc_network_cidr, 2)

    # platform setup
    cloudflare_tunnel_token = var.cloudflare_tunnel_token

    # datastore setup
    filestore_host = module.filestore.hostname

    docker_hub_user  = var.docker_hub_user
    docker_hub_token = var.docker_hub_token
  }
}

module "k8s_bootstrap_node" {
  count           = 1
  source          = "../virtual-machine"
  name            = "${var.cluster_name}-bootstrap-node-${count.index}"
  datastore_name  = var.datastore_name
  base_volume_id  = var.base_volume_id
  network_id      = libvirt_network.vpc_network.id
  addresses       = [cidrhost(var.vpc_network_cidr, 10)]
  cpu_count       = local.control_plane_resources.cpu_count
  memory_size_mib = local.control_plane_resources.memory_size_mib
  disk_size_mib   = local.control_plane_resources.disk_size_mib

  launch_script = templatefile("${path.module}/templates/cluster_script.sh", merge({ node_type = "bootstrap_node" }, local.cluster_launch_script_inputs))

  depends_on = [module.filestore]
}

module "k8s_control_plane" {
  count           = 2
  source          = "../virtual-machine"
  name            = "${var.cluster_name}-control-plane-${count.index}"
  datastore_name  = var.datastore_name
  base_volume_id  = var.base_volume_id
  network_id      = libvirt_network.vpc_network.id
  addresses       = [cidrhost(var.vpc_network_cidr, 11 + count.index)]
  cpu_count       = local.control_plane_resources.cpu_count
  memory_size_mib = local.control_plane_resources.memory_size_mib
  disk_size_mib   = local.control_plane_resources.disk_size_mib

  launch_script = templatefile("${path.module}/templates/cluster_script.sh", merge({ node_type = "control_plane" }, local.cluster_launch_script_inputs))
  depends_on    = [module.filestore, module.k8s_bootstrap_node]
}

module "k8s_worker_nodes" {
  count           = var.vm_node_count
  source          = "../virtual-machine"
  name            = "${var.cluster_name}-worker-node-${count.index}"
  datastore_name  = var.datastore_name
  base_volume_id  = var.base_volume_id
  network_id      = libvirt_network.vpc_network.id
  addresses       = [cidrhost(var.vpc_network_cidr, 20 + count.index)]
  cpu_count       = var.vm_cpu_count
  memory_size_mib = var.vm_memory_size_mib
  disk_size_mib   = var.vm_disk_size_mib
  data_disks      = var.vm_data_disks

  launch_script = templatefile("${path.module}/templates/cluster_script.sh", merge({ node_type = "worker_node" }, local.cluster_launch_script_inputs))

  depends_on = [module.filestore, module.k8s_control_plane]
}

module "filestore" {
  # source         = "git::https://github.com/tenzin-io/terraform-modules.git//libvirt/virtual-machine?ref=main"
  source         = "../virtual-machine"
  name           = "${var.cluster_name}-filestore"
  datastore_name = var.datastore_name
  base_volume_id = var.base_volume_id
  network_id     = libvirt_network.vpc_network.id
  addresses      = [cidrhost(var.vpc_network_cidr, 3)]

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

# module "agent_node" {
#   count = 1
#   source          = "../virtual-machine"
#   name            = "${var.cluster_name}-agent-node-${count.index}"
#   datastore_name  = var.datastore_name
#   base_volume_id  = var.base_volume_id
#   network_id      = libvirt_network.vpc_network.id
#   addresses       = [cidrhost(var.vpc_network_cidr, 4)]
#   cpu_count       = 2
#   memory_size_mib = 4 * 1024 // gib
#   disk_size_mib   = 30 * 1024 // gib
#
#   launch_script = templatefile("${path.module}/templates/agent_script.sh", {
#     cloudflare_tunnel_token  = var.cloudflare_tunnel_token
#     tailscale_auth_key = var.tailscale_auth_key
#   })
#
#   depends_on = [module.filestore]
# }