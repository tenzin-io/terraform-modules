variable "pod_cidr_network" {
  type        = string
  default     = "10.10.0.0/16"
  description = "The pod CIDR network to use for the Calico installation."
}