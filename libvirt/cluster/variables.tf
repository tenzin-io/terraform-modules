variable "cluster_name" {
  type        = string
  description = "The name of the cluster"
}

variable "cluster_uuid" {
  type        = string
  description = "The UUID of the cluster"
}

variable "control_plane_node_count" {
  type        = number
  default     = 0
  description = "The number of control plane nodes in the cluster"
  validation {
    condition     = var.control_plane_node_count >= 0 && var.control_plane_node_count < 9
    error_message = "The control plane node count must be between 0 - 9."
  }
}

variable "worker_node_count" {
  type        = number
  default     = 2
  description = "The number of worker nodes in the cluster"
  validation {
    condition     = var.worker_node_count >= 0 && var.worker_node_count < 9
    error_message = "The control plane node count must be between 0 - 9."
  }
}

variable "worker_memory_size_mib" {
  type    = number
  default = 2048
}

variable "worker_disk_size_mib" {
  type    = number
  default = 1024
}

variable "worker_cpu_count" {
  type    = number
  default = 2
}

variable "worker_data_disks" {
  type = map(object({
    mount_path    = string
    disk_size_mib = number
    fs_type       = optional(string, "ext4")
  }))
  default     = {}
  description = "A map of data disks to add to the virtual machine"
}

variable "vpc_network_cidr" {
  type        = string
  description = "The VM network CIDR block"
}

variable "vpc_domain_name" {
  type        = string
  default     = "virtual.lan"
  description = "The domain name of the VM network"
}

variable "vpc_network_mode" {
  type        = string
  default     = "nat"
  description = "Whether the hypervisor should 'nat' the network or 'route' the network"
}

variable "alternative_domain_names" {
  type        = list(string)
  default     = []
  description = "A list of alternative domain names for the VM network"
}

variable "datastore_path_prefix" {
  type        = string
  default     = "/data"
  description = "The hypervisor host path prefix"
}

variable "docker_hub_user" {
  type      = string
  sensitive = true
}

variable "docker_hub_token" {
  type      = string
  sensitive = true
}

variable "create_agent_node" {
  type    = bool
  default = false
}

variable "tailscale_auth_key" {
  type      = string
  sensitive = true
  default   = ""
}

variable "cloudflare_tunnel_token" {
  type      = string
  sensitive = true
  default   = ""
}

variable "shared_filesystem_path" {
  type    = string
  default = "/data/shared"
}

variable "vault_address" {
  type = string
}

variable "vault_username" {
  type = string
}

variable "vault_password" {
  type      = string
  sensitive = true
}
