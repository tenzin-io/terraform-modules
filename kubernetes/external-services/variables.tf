variable "namespace" {
  type        = string
  description = "The namespace to deploy the ingresses for external services."
  default     = "external-services"
}

variable "external_services" {
  type = map(object({
    virtual_host      = string
    address           = string
    protocol          = string
    port              = string
    request_body_size = optional(string, "100m")
  }))
  default     = {}
  description = "A map of external services."
}

variable "redirect_services" {
  type = map(object({
    virtual_host = string
    redirect_url = string
  }))
  default     = {}
  description = "A map of redirect services."
}

variable "cert_issuer_name" {
  type        = string
  description = "The name of the certificate issuer, from cert-manager."
  default     = "lets-encrypt"
}
