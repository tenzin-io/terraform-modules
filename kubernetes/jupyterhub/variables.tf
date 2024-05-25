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
  description = "The GitHub OAuth client ID."
}

variable "github_oauth_client_secret" {
  type        = string
  sensitive   = true
  description = "The GitHub OAuth client secret."
}

variable "allowed_github_organizations" {
  type        = set(string)
  description = "The list of GitHub organizations that are allowed to access Jupyter Hub."
}
