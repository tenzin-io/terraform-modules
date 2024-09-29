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
