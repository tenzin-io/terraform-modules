variable "network_cidr" {
  type = string
}

variable "domain_name" {
  type = string
}

variable "network_name" {
  type    = string
  default = "vm-network"
}

variable "hypervisor_ip" {
  type = string
}
