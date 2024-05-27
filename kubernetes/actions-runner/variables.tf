variable "namespace" {
  description = "The namespace to deploy the actions-runner-controller"
  type        = string
  default     = "actions-runner"
}

variable "github_org_url" {
  description = "The GitHub Organization URL"
  type        = string
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

variable "runner_image" {
  description = "The image to use for the runner"
  type        = string
  default     = "ghcr.io/actions/actions-runner:latest"
}

variable "runner_set_name" {
  description = "The name of the runner set"
  type        = string
}

variable "minimum_runners" {
  description = "The minimum number of runners to scale to"
  type        = number
  default     = 1
}

variable "maximum_runners" {
  description = "The maximum number of runners to scale to"
  type        = number
  default     = 5
}