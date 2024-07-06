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
  description = "A map of external services"
}

variable "external_domain_name" {
  type        = string
  description = "The external domain name to append to the service name"
}

variable "request_body_size" {
  type        = string
  default     = "100m"
  description = "The maximum size of the request body"
}

variable "certificate_issuer" {
  type        = string
  default     = "lets-encrypt"
  description = "The name of the certificate issuer for the cluster"
}