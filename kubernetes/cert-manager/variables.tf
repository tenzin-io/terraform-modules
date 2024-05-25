variable "namespace" {
  type        = string
  default     = "cert-manager"
  description = "The namespace to deploy cert-manager"
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