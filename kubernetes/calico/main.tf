resource "helm_release" "calico" {
  name             = "calico"
  namespace        = "tigera-operator"
  create_namespace = true
  repository       = "https://projectcalico.docs.tigera.io/charts"
  chart            = "tigera-operator"
  version          = "v3.28.0"
  wait             = true
  values = [templatefile("${path.module}/templates/values.yaml", {
    pod_cidr_network = var.pod_cidr_network
  })]
}