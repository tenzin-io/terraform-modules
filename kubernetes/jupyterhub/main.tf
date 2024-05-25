terraform {
  required_version = "~> 1.0" 
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.0"
    }
  }
}

resource "helm_release" "jupyterhub" {
  name             = "jupyterhub"
  chart            = "jupyterhub"
  repository       = "https://hub.jupyter.org/helm-chart/"
  version          = "3.3.7"
  namespace        = "jupyterhub"
  create_namespace = true
  values = [
    templatefile("${path.module}/templates/values.yaml", {
      jupyterhub_fqdn              = var.jupyterhub_fqdn,
      enable_github_oauth          = var.enable_github_oauth,
      github_oauth_client_id       = var.github_oauth_client_id,
      github_oauth_client_secret   = var.github_oauth_client_secret,
      allowed_github_organizations = var.allowed_github_organizations,
      cert_issuer_name             = var.cert_issuer_name,
    })
  ]
}
