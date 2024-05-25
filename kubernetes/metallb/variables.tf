variable "ip_pool_range" {
  type        = string
  description = "The IP address pool range given to MetalLB."
}

variable "namespace" {
  type        = string
  default     = "metallb"
  description = "The namespace for MetalLB deployment."
}
