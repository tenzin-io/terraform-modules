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

variable "data_disks" {
  type = map(object({
    mount_path    = string
    disk_size_mib = number
    fs_type       = optional(string, "ext4")
  }))
  default     = {}
  description = "A map of data disks to add to the virtual machine"
}

variable "launch_script" {
  type        = string
  default     = ""
  description = "The a custom script to run on the machine after cloud-init has finished"
}

variable "base_volume" {
  type = object({
    id   = string
    name = string
    pool = string
  })
  description = "The base volume to use for the OS root disk"
}