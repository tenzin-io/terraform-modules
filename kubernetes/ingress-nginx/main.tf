resource "kubernetes_namespace_v1" "nginx_namespace" {
  metadata {
    name = var.namespace
  }
}

resource "helm_release" "ingress_nginx" {
  name             = "ingress-nginx"
  chart            = "ingress-nginx"
  namespace        = var.namespace
  repository       = "https://kubernetes.github.io/ingress-nginx"
  version          = "4.10.1"
  create_namespace = false
  values = [templatefile("${path.module}/templates/values.yaml", {
    enable_tailscale_tunnel    = var.enable_tailscale_tunnel,
    nginx_service_type         = var.nginx_service_type,
    nginx_service_account_name = var.nginx_service_account_name,
    tailscale_hostname         = var.tailscale_hostname,
  })]
  depends_on = [
    kubernetes_namespace_v1.nginx_namespace,
    kubernetes_role_binding_v1.tailscale_role_binding,
    kubernetes_secret_v1.tailscale_auth_key_secret
  ]
}