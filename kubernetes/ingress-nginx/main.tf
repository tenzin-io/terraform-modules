terraform {
  required_version = "~> 1.0"
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
  }
}
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
    enable_cloudflare_tunnel   = var.enable_cloudflare_tunnel,
    cloudflare_tunnel_token    = var.cloudflare_tunnel_token,
  })]
  depends_on = [
    kubernetes_namespace_v1.nginx_namespace,
    kubernetes_role_binding_v1.tailscale_role_binding,
    kubernetes_secret_v1.tailscale_auth_key_secret,
    kubernetes_secret_v1.cloudflare_tunnel_token_secret
  ]
}