variable "namespace" {
  description = "The namespace to deploy the actions-runner-controller"
  type        = string
  default     = "actions-runner"
}

variable "github_app_id" {
  description = "The GitHub App ID"
  type        = number
  sensitive   = true
}

variable "github_app_installation_id" {
  description = "The GitHub App Installation ID"
  type        = number
  sensitive   = true
}

variable "github_app_private_key" {
  description = "The GitHub App Private Key"
  type        = string
  sensitive   = true
}