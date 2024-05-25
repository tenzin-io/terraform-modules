resource "kubernetes_secret_v1" "tailscale_auth_key_secret" {
  count = var.enable_tailscale_tunnel ? 1 : 0
  metadata {
    name      = "tailscale-auth-key"
    namespace = var.namespace
  }
  data = {
    authKey = var.tailscale_auth_key
  }
  depends_on = [kubernetes_namespace_v1.nginx_namespace]
}

resource "kubernetes_role_v1" "tailscale_role" {
  count = var.enable_tailscale_tunnel ? 1 : 0
  metadata {
    name      = "tailscale-role"
    namespace = var.namespace
  }

  rule {
    api_groups     = [""]
    resources      = ["secrets"]
    resource_names = ["tailscale-auth-key", "tailscale-auth-state"]
    verbs          = ["get", "update", "patch"]
  }
  rule {
    api_groups = [""]
    resources  = ["secrets"]
    verbs      = ["create"]
  }
  depends_on = [kubernetes_namespace_v1.nginx_namespace]
}

resource "kubernetes_role_binding_v1" "tailscale_role_binding" {
  count = var.enable_tailscale_tunnel ? 1 : 0
  metadata {
    name      = "tailscale-role-binding"
    namespace = var.namespace
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = "tailscale-role"
  }
  subject {
    kind      = "ServiceAccount"
    name      = var.nginx_service_account_name
    namespace = var.namespace
  }
  depends_on = [kubernetes_namespace_v1.nginx_namespace]
}
