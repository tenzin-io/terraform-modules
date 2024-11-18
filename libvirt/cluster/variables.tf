variable "cluster_name" {
  type        = string
  description = "The name of the cluster"
}

variable "vm_node_count" {
  type        = number
  default     = 2
  description = "The number of virtual machine nodes in the cluster"
}

variable "vm_memory_size_mib" {
  type    = number
  default = 2048
}

variable "vm_disk_size_mib" {
  type    = number
  default = 1024
}

variable "vm_cpu_count" {
  type    = number
  default = 2
}


variable "vm_data_disks" {
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

variable "alternative_domain_names" {
  type        = list(string)
  default     = []
  description = "A list of alternative domain names for the VM network"
}

variable "datastore_name" {
  type = string
}

variable "base_volume_id" {
  type = string
}

variable "tailscale_auth_key" {
  type      = string
  sensitive = true
  default = ""
}

variable "cloudflare_tunnel_token" {
  type      = string
  sensitive = true
  default = ""
}

variable "docker_hub_user" {
  type      = string
  sensitive = true
}

variable "docker_hub_token" {
  type      = string
  sensitive = true
}