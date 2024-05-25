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

resource "kubernetes_secret_v1" "cloudflare_api_token" {
  metadata {
    name      = "cloudflare-api-token"
    namespace = var.namespace
  }

  data = {
    token = var.cloudflare_api_token
  }
}

resource "kubernetes_manifest" "lets_encrypt_cluster_issuer" {
  count = var.enable_lets_encrypt_issuer == true ? 1 : 0
  depends_on = [helm_release.cert_manager, kubernetes_secret_v1.cloudflare_api_token]
  manifest = {
    apiVersion = "apiextensions.k8s.io/v1"
    kind       = "CustomResourceDefinition"

    metadata = {
      name = "lets-encrypt"
      namespace = var.namespace
    }

    spec = {
      acme = {
        server = "https://acme-v02.api.letsencrypt.org/directory"
        private_key_secret_ref = {
          name = "lets-encrypt-issuer-private-key"
        }

        solvers = {
          dns01 = {
            cloudflare = {
              api_token_secret_ref = {
                name = "cloudflare-api-token"
                key  = "token"
              }
            }
          }
        }
      }
    }
  }
}
