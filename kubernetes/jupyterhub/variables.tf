variable "jupyterhub_fqdn" {
  type        = string
  description = "The fully qualified name of Jupyter Hub instance."
}

variable "cert_issuer_name" {
  type        = string
  description = "The name of the cert-manager certificate issuer"
}

variable "enable_github_oauth" {
  type        = bool
  default     = false
  description = "Enable GitHub OAuth for Jupyter Hub."
}

variable "github_oauth_client_id" {
  type        = string
  default     = null
  description = "The GitHub OAuth client ID."
}

variable "github_oauth_client_secret" {
  type        = string
  default     = null
  sensitive   = true
  description = "The GitHub OAuth client secret."
}

variable "allowed_github_organizations" {
  type        = set(string)
  description = "The list of GitHub organizations that are allowed to access Jupyter Hub."
  default     = null
}

variable "jupyter_image_name" {
  type        = string
  default     = "quay.io/jupyterhub/k8s-singleuser-sample"
  description = "The Jupyter notebook image to use"
}

variable "jupyter_image_tag" {
  type        = string
  default     = "3.3.7"
  description = "The Jupyter notebook image tag to use"
}

variable "nvidia_gpu_enabled" {
  type        = bool
  default     = false
  description = "The Jupyter notebook requests GPU resources"
}
