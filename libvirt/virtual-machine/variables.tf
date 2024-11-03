variable "datastore_name" {
  type        = string
  description = "The name of the datastore"
}

variable "domain_name" {
  type        = string
  default     = "virtual.lan"
  description = "The name of the domain"
}

variable "name" {
  type        = string
  description = "The name of the virtual machine"
}

variable "memory_size_mib" {
  type    = number
  default = 2048
}

variable "disk_size_mib" {
  type    = number
  default = 1024
}

variable "cpu_count" {
  type    = number
  default = 2
}

variable "addresses" {
  type        = list(string)
  description = "A list of 1 IPv4 address and/or IPv6 address"
}

variable "network_id" {
  type = string
}

variable "base_volume_id" {
  type = string
}

variable "gpu_pci_bus" {
  type        = string
  default     = null
  description = "The PCI bus number of the GPU device"
}

variable "data_disks" {
  type = map(object({
    disk_size_mib = number
  }))
  default     = {}
  description = "A map of data disks to add to the virtual machine"
}