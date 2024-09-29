variable "vm_network_cidr" {
  type = string
}

variable "vm_domain_name" {
  type = string
}

variable "vm_network_name" {
  type    = string
  default = "vm-network"
}

variable "hypervisor_ip" {
  type = string
}
