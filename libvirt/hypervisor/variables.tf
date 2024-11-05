variable "vm_network_cidr" {
  type        = string
  description = "The VM network CIDR block"
}

variable "vm_domain_name" {
  type        = string
  description = "The domain name of the VM network"
}

variable "vm_network_name" {
  type        = string
  default     = "vm-network"
  description = "The hypervisor local VM network name"
}

variable "hypervisor_ip" {
  type        = string
  description = "The hypervisor IP address"
}

variable "dns_host_records" {
  type = list(object({
    hostname    = string
    host_number = string
  }))
  default     = []
  description = "A list of host records to create in the virtual domain"
}

variable "dhcp_range_start" {
  type        = number
  default     = 10
  description = "The start host number of the DHCP range"
}

variable "dhcp_range_end" {
  type        = number
  default     = 150
  description = "The end host number of the DHCP range"
}

variable "datastore_name" {
  type        = string
  description = "The name of the datastore"
  default     = "datastore"
}

variable "datastore_path" {
  type        = string
  default     = "/var/lib/libvirt/machines"
  description = "The datastore folder path"
}