resource "kubernetes_secret_v1" "cloudflare_tunnel_token_secret" {
  count = var.enable_cloudflare_tunnel ? 1 : 0
  metadata {
    name      = "cloudflare-tunnel-token"
    namespace = var.namespace
  }
  data = {
    token = var.cloudflare_tunnel_token
  }
  depends_on = [kubernetes_namespace_v1.nginx_namespace]
}