locals {
  cluster_launch_script_inputs = {
    # kubernetes setup
    vpc_domain_name               = var.vpc_domain_name
    alternative_domain_names      = var.alternative_domain_names
    cluster_name                  = var.cluster_name
    cluster_uuid                  = var.cluster_uuid
    cluster_api_listen_port       = 6443
    cluster_virtual_hostname      = "kubernetes"
    cluster_virtual_ip            = cidrhost(var.vpc_network_cidr, 2)
    cluster_loadbalancer_ip       = cidrhost(var.vpc_network_cidr, 3)
    skip_phase_mark_control_plane = false

    # platform setup
    vault_address           = var.vault_address
    vault_username          = var.vault_username
    vault_password          = var.vault_password
    cloudflare_tunnel_token = var.cloudflare_tunnel_token
    docker_hub_user         = var.docker_hub_user
    docker_hub_token        = var.docker_hub_token

    # filestore details
    filestore_host         = module.filestore[0].hostname
    shared_filesystem_path = var.shared_filesystem_path
  }
}

module "k8s_bootstrap_node" {
  count           = 1
  source          = "../virtual-machine"
  name            = "${var.cluster_name}-${var.cluster_uuid}-bootstrap-node-${count.index}"
  datastore_name  = libvirt_pool.datastore.name
  base_volume     = var.base_volume
  network_id      = libvirt_network.vpc_network.id
  addresses       = [cidrhost(var.vpc_network_cidr, 10)]
  cpu_count       = 2
  memory_size_mib = 6 * 1024  // gib
  disk_size_mib   = 40 * 1024 // gib

  launch_script = templatefile("${path.module}/templates/cluster_script.sh",
    merge(local.cluster_launch_script_inputs, {
      node_type    = "bootstrap_node"
      cluster_uuid = var.cluster_uuid
    })
  )

  depends_on = [module.filestore]
}

module "k8s_control_plane" {
  count           = var.control_plane_node_count
  source          = "../virtual-machine"
  name            = "${var.cluster_name}-${var.cluster_uuid}-control-plane-${count.index}"
  datastore_name  = libvirt_pool.datastore.name
  base_volume     = var.base_volume
  network_id      = libvirt_network.vpc_network.id
  addresses       = [cidrhost(var.vpc_network_cidr, 11 + count.index)]
  cpu_count       = 2
  memory_size_mib = 4 * 1024  // gib
  disk_size_mib   = 30 * 1024 // gib

  launch_script = templatefile("${path.module}/templates/cluster_script.sh",
    merge(local.cluster_launch_script_inputs, {
      node_type    = "control_plane"
      cluster_uuid = var.cluster_uuid
    })
  )
  depends_on = [module.k8s_bootstrap_node]
}

module "k8s_worker_nodes" {
  count           = var.worker_node_count
  source          = "../virtual-machine"
  name            = "${var.cluster_name}-${var.cluster_uuid}-worker-node-${count.index}"
  datastore_name  = libvirt_pool.datastore.name
  base_volume     = var.base_volume
  network_id      = libvirt_network.vpc_network.id
  addresses       = [cidrhost(var.vpc_network_cidr, 20 + count.index)]
  cpu_count       = var.worker_cpu_count
  memory_size_mib = var.worker_memory_size_mib
  disk_size_mib   = var.worker_disk_size_mib
  data_disks      = var.worker_data_disks

  launch_script = templatefile("${path.module}/templates/cluster_script.sh",
    merge(local.cluster_launch_script_inputs, {
      node_type    = "worker_node"
      cluster_uuid = var.cluster_uuid
    })
  )
  depends_on = [module.k8s_control_plane]
}

module "filestore" {
  count          = 1
  source         = "../virtual-machine"
  name           = "${var.cluster_name}-${var.cluster_uuid}-filestore-${count.index}"
  datastore_name = libvirt_pool.datastore.name
  base_volume    = var.base_volume
  network_id     = libvirt_network.vpc_network.id
  addresses      = [cidrhost(var.vpc_network_cidr, 4)]

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
  launch_script = templatefile("${path.module}/templates/filestore_script.sh", {
    filestore_clients      = var.vpc_network_cidr
    shared_filesystem_path = var.shared_filesystem_path
  })
}

module "agent_node" {
  count           = var.create_agent_node ? 1 : 0
  source          = "../virtual-machine"
  name            = "${var.cluster_name}-${var.cluster_uuid}-agent-node-${count.index}"
  datastore_name  = libvirt_pool.datastore.name
  base_volume     = var.base_volume
  network_id      = libvirt_network.vpc_network.id
  addresses       = [cidrhost(var.vpc_network_cidr, 5)]
  cpu_count       = 4
  memory_size_mib = 8 * 1024  // gib
  disk_size_mib   = 30 * 1024 // gib

  launch_script = templatefile("${path.module}/templates/agent_script.sh", {
    tailscale_auth_key      = var.tailscale_auth_key,
    cloudflare_tunnel_token = var.cloudflare_tunnel_token
  })

  depends_on = [module.filestore]
}