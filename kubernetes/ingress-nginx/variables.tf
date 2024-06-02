variable "enable_tailscale_tunnel" {
  type        = bool
  description = "Enable Tailscale tunnel on Nginx controller."
  default     = false
}

variable "tailscale_hostname" {
  type        = string
  description = "The Tailscale hostname to join to a Tailscale network."
  default     = null
}

variable "tailscale_auth_key" {
  type        = string
  description = "The Tailscale auth key to join to a Tailscale network."
  default     = null
  sensitive   = true
}

variable "enable_cloudflare_tunnel" {
  type        = bool
  description = "Enable Cloudflare tunnel on Nginx controller."
  default     = false
}

variable "cloudflare_tunnel_token" {
  type        = string
  description = "The Cloudflare tunnel token to join to a Cloudflare network."
  default     = null
}

variable "namespace" {
  type        = string
  default     = "ingress-nginx"
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