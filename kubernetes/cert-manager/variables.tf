variable "namespace" {
  type        = string
  default     = "cert-manager"
  description = "The namespace to deploy cert-manager"
}

variable "cert_issuer_name" {
  type        = string
  default     = "lets-encrypt"
  description = "The name of the certificate issuer"
}

variable "cloudflare_api_token" {
  type        = string
  description = "CloudFlare API token"
  sensitive   = true
}

variable "enable_lets_encrypt_issuer" {
  type        = bool
  default     = true
  description = "Enable the Lets Encrypt issuer"
}