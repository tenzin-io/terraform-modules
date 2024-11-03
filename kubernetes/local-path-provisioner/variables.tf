variable "default_storage_class" {
  type        = bool
  default     = true
  description = "Set the local-path-provisioner to be the default storage class for persistent volume claims"
}
variable "local_path" {
  type        = string
  default     = "/opt/local-path-provisioner"
  description = "The path on the node in which to place persistent volumes"
}