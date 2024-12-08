variable "name" {
  type        = string
  description = "The name of the virtual network."
}

variable "network_cidr" {
  type        = string
  description = "The virtual network CIDR block."
}

variable "domain_name" {
  type        = string
  default     = "virtual.lan"
  description = "The domain name of the virtual network."
}

variable "routing_mode" {
  type    = string
  default = "nat"
}

variable "dhcp_range_start" {
  type    = number
  default = 100
}

variable "dhcp_range_end" {
  type    = number
  default = 200
}

variable "dns_hosts" {
  type = list(object({
    hostname = string
    ip       = string
  }))
  default = []
}