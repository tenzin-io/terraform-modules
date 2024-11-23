locals {
  cluster_launch_script_inputs = {
    # kubernetes setup
    vpc_domain_name               = var.vpc_domain_name
    alternative_domain_names      = var.alternative_domain_names
    cluster_api_listen_port       = 8001
    cluster_virtual_hostname      = "${var.cluster_name}-control"
    cluster_virtual_ip            = cidrhost(var.vpc_network_cidr, 2)
    skip_phase_mark_control_plane = false

    # platform setup
    cloudflare_tunnel_token = var.cloudflare_tunnel_token
    docker_hub_user         = var.docker_hub_user
    docker_hub_token        = var.docker_hub_token

    # filestore details
    filestore_host         = module.filestore[0].hostname
    shared_filesystem_path = local.filestore_launch_script_inputs.shared_filesystem_path
  }
}

module "k8s_bootstrap_node" {
  count           = 1
  source          = "../virtual-machine"
  name            = "${var.cluster_name}-bootstrap-node-${count.index}"
  datastore_name  = libvirt_pool.datastore.name
  base_volume     = var.base_volume
  network_id      = libvirt_network.vpc_network.id
  addresses       = [cidrhost(var.vpc_network_cidr, 10)]
  cpu_count       = local.control_plane_resources.cpu_count
  memory_size_mib = local.control_plane_resources.memory_size_mib
  disk_size_mib   = local.control_plane_resources.disk_size_mib

  launch_script = templatefile("${path.module}/templates/cluster_script.sh",
    merge(local.cluster_launch_script_inputs, {
      node_type                     = "bootstrap_node",
      skip_phase_mark_control_plane = true,
    })
  )

  depends_on = [module.filestore]
}

locals {
  control_plane_resources = {
    cpu_count       = 2
    memory_size_mib = 4 * 1024  // gib
    disk_size_mib   = 30 * 1024 // gib
  }
}

module "k8s_control_plane" {
  count           = 2
  source          = "../virtual-machine"
  name            = "${var.cluster_name}-control-plane-${count.index}"
  datastore_name  = libvirt_pool.datastore.name
  base_volume     = var.base_volume
  network_id      = libvirt_network.vpc_network.id
  addresses       = [cidrhost(var.vpc_network_cidr, 11 + count.index)]
  cpu_count       = local.control_plane_resources.cpu_count
  memory_size_mib = local.control_plane_resources.memory_size_mib
  disk_size_mib   = local.control_plane_resources.disk_size_mib

  launch_script = templatefile("${path.module}/templates/cluster_script.sh",
    merge(local.cluster_launch_script_inputs, {
      node_type = "control_plane"
    })
  )
  depends_on = [module.k8s_bootstrap_node]
}

module "k8s_worker_nodes" {
  count           = var.vm_node_count
  source          = "../virtual-machine"
  name            = "${var.cluster_name}-worker-node-${count.index}"
  datastore_name  = libvirt_pool.datastore.name
  base_volume     = var.base_volume
  network_id      = libvirt_network.vpc_network.id
  addresses       = [cidrhost(var.vpc_network_cidr, 20 + count.index)]
  cpu_count       = var.vm_cpu_count
  memory_size_mib = var.vm_memory_size_mib
  disk_size_mib   = var.vm_disk_size_mib
  data_disks      = var.vm_data_disks

  launch_script = templatefile("${path.module}/templates/cluster_script.sh",
    merge(local.cluster_launch_script_inputs, {
      node_type = "worker_node"
    })
  )
  depends_on = [module.k8s_control_plane]
}

locals {
  filestore_launch_script_inputs = {
    filestore_clients      = var.vpc_network_cidr
    shared_filesystem_path = "/data/shared"
  }
}

module "filestore" {
  count          = 1
  source         = "../virtual-machine"
  name           = "${var.cluster_name}-filestore-${count.index}"
  datastore_name = libvirt_pool.datastore.name
  base_volume    = var.base_volume
  network_id     = libvirt_network.vpc_network.id
  addresses      = [cidrhost(var.vpc_network_cidr, 3)]

  cpu_count       = 2
  memory_size_mib = 8 * 1024  // gib
  disk_size_mib   = 48 * 1024 // gib
  data_disks = {
    "/dev/vdb" = {
      disk_size_mib = 128 * 1024 // gib
      fs_type       = "ext4"
      mount_path    = "/data"
    }
  }
  launch_script = templatefile("${path.module}/templates/filestore_script.sh", local.filestore_launch_script_inputs)
}

module "agent_node" {
  count           = 1
  source          = "../virtual-machine"
  name            = "${var.cluster_name}-agent-node-${count.index}"
  datastore_name  = libvirt_pool.datastore.name
  base_volume     = var.base_volume
  network_id      = libvirt_network.vpc_network.id
  addresses       = [cidrhost(var.vpc_network_cidr, 4)]
  cpu_count       = 2
  memory_size_mib = 2 * 1024  // gib
  disk_size_mib   = 30 * 1024 // gib

  launch_script = templatefile("${path.module}/templates/agent_script.sh", {
    cloudflare_tunnel_token = var.cloudflare_tunnel_token
    tailscale_auth_key      = var.tailscale_auth_key
  })

  depends_on = [module.filestore]
}