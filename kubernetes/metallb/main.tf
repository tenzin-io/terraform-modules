resource "helm_release" "metallb" {
  name             = "metallb"
  repository       = "https://metallb.github.io/metallb"
  chart            = "metallb"
  version          = "0.13.9"
  create_namespace = true
  namespace        = var.namespace
}


resource "helm_release" "metallb_config" {
  depends_on       = [helm_release.metallb]
  name             = "metallb"
  namespace        = var.namespace
  create_namespace = false
  repository       = "oci://ghcr.io/tenzin-io"
  chart            = "metallb-config"
  version          = "v0.0.0"
  wait             = true
  set {
    name  = "addressPool"
    value = var.ip_pool_range
  }
}
