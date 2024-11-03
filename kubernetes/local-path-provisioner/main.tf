resource "helm_release" "local_path_provisioner" {
  name             = "local-path-provisioner"
  namespace        = "kube-system"
  create_namespace = false
  repository       = "oci://ghcr.io/tenzin-io"
  chart            = "local-path-provisioner"
  version          = "v0.0.30"
  wait             = true

  set {
    name  = "image.tag"
    value = "v0.0.30"
  }

  set {
    name  = "storageClass.defaultClass"
    value = var.default_storage_class
  }

  set {
    name  = "nodePathMap[0].paths[0]"
    value = var.local_path
  }
}