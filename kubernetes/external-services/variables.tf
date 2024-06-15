variable "namespace" {
  type        = string
  description = "The namespace to deploy the ingresses for external services."
  default     = "external-services"
}

variable "external_services" {
  type = map(object({
    address = string
    port    = string
  }))
  default     = {}
  description = "A map of external services."
}