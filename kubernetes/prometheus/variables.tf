variable "enable_alertmanager" {
  default     = false
  type        = bool
  description = "Enable Alertmanager"
}

variable "alert_receiver_name" {
  default     = ""
  type        = string
  description = "Name of the alertmanager receiver"
}

variable "alert_receiver_url" {
  default     = ""
  type        = string
  description = "API endpoint to send webhook alert requests"
}

variable "alert_receiver_username" {
  default     = ""
  type        = string
  description = "Username to use with the alert receiver API"
}

variable "alert_receiver_password" {
  default     = ""
  type        = string
  sensitive   = true
  description = "Password to use with the alert receiver API"
}

variable "namespace" {
  default     = "monitoring"
  type        = string
  description = "The namespace to deploy Prometheus."
}

variable "metrics_retention_duration" {
  default     = "14d"
  type        = string
  description = "The duration to keep metrics."
}

variable "metrics_scrape_interval" {
  default     = "60s"
  type        = string
  description = "The frequency at which to collect metrics."
}

variable "prometheus_volume_size" {
  default     = "10Gi"
  type        = string
  description = "The volume size for Prometheus persistent volume."
}

variable "kubernetes_cluster_name" {
  default     = "kubernetes"
  type        = string
  description = "Add a label to the metrics identify the cluster name."
}

variable "prometheus_fqdn" {
  default     = "prometheus.lan"
  type        = string
  description = "The Prometheus DNS name to place on ingress."
}

variable "enable_ingress" {
  type        = bool
  default     = false
  description = "Create a Prometheus ingress."
}

variable "enable_basic_auth" {
  type        = bool
  default     = false
  description = "Protect ingress using basic auth."
}

variable "basic_auth_password" {
  type        = string
  default     = null
  description = "The basic auth credentials."
}