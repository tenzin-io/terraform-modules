resource "helm_release" "local_path_provisioner" {
  name             = "local-path-provisioner"
  namespace        = "kube-system"
  create_namespace = false
  repository       = "oci://ghcr.io/tenzin-io"
  chart            = "local-path-provisioner"
  version          = "v0.0.26-tenzin"
  wait             = true
  values           = [templatefile("${path.module}/templates/values.yaml", {})]
}