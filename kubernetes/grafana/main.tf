terraform {
  required_version = "~> 1.0"
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.0"
    }
  }
}

resource "helm_release" "grafana" {
  name             = "grafana"
  chart            = "grafana"
  repository       = "https://grafana.github.io/helm-charts"
  version          = "7.3.11"
  namespace        = var.namespace
  create_namespace = true
  values = [
    templatefile("${path.module}/templates/values.yaml", {
      grafana_volume_size        = var.grafana_volume_size
      grafana_fqdn               = var.grafana_fqdn
      cert_issuer_name           = var.cert_issuer_name
      enable_github_oauth        = var.enable_github_oauth
      github_org_name            = var.github_org_name
      github_oauth_client_id     = var.github_oauth_client_id
      github_oauth_client_secret = var.github_oauth_client_secret
    })
  ]
}