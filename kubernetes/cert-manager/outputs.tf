output "cert_issuer_name" {
  value       = try(kubernetes_manifest.lets_encrypt_cluster_issuer.0.metadata.0.name, null)
  description = "The name of the certificate issuer"
}
