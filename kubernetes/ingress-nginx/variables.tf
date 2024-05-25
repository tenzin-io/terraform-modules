variable "enable_tailscale_tunnel" {
  type        = bool
  description = "Enable Tailscale tunnel on Nginx controller."
  default     = false
}

variable "tailscale_auth_key" {
  type        = string
  description = "The Tailscale auth key to join to a Tailscale network."
  default     = null
  sensitive   = true
}

variable "namespace" {
  type        = string
  default     = "nginx"
  description = "The namespace to deploy Nginx."
}

variable "nginx_service_type" {
  type        = string
  default     = "LoadBalancer"
  description = "The type of Nginx ingress service. Ex. NodePort or LoadBalancer."
}

variable "nginx_service_account_name" {
  type        = string
  default     = "ingress-nginx"
  description = "The service account name for Nginx ingress controller."
}