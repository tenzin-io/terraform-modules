resource "helm_release" "cert_manager" {
  name             = "cert-manager"
  namespace        = var.namespace
  create_namespace = true
  repository       = "https://charts.jetstack.io"
  chart            = "cert-manager"
  version          = "v1.14.5"

  set {
    name  = "installCRDs"
    value = true
  }
}

resource "helm_release" "cert_manager_config" {
  depends_on = [ helm_release.cert_manager ]
  name             = "cert-manager-config"
  namespace        = var.namespace
  create_namespace = false
  repository       = "oci://ghcr.io/tenzin-io"
  chart            = "cert-manager-config"
  version          = "v0.0.1"
  wait             = true

  set {
    name = "cloudflare.apiToken"
    value = var.cloudflare_api_token
  }
}