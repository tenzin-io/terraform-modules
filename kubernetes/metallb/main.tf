resource "helm_release" "metallb" {
  name             = "metallb"
  repository       = "https://metallb.github.io/metallb"
  chart            = "metallb"
  version          = "0.14.5"
  create_namespace = true
  namespace        = var.namespace
}


resource "helm_release" "metallb_config" {
  depends_on       = [helm_release.metallb]
  name             = "metallb-config"
  namespace        = var.namespace
  create_namespace = false
  repository       = "oci://ghcr.io/tenzin-io"
  chart            = "metallb-config"
  version          = "v0.0.5"
  set {
    name  = "addressPool"
    value = var.ip_pool_range
  }
}
