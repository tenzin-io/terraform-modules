terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.0"
    }
  }
  required_version = "~> 1.0"
}

resource "helm_release" "external_service" {
  for_each         = var.external_services
  repository       = "oci://ghcr.io/tenzin-io"
  chart            = "external-service"
  version          = "v0.0.0"
  wait             = true
  name             = each.key
  namespace        = var.namespace
  create_namespace = true

  set {
    name  = "serviceName"
    value = each.key
  }

  set {
    name  = "originServer.address"
    value = each.value.address
  }

  set {
    name  = "originServer.port"
    value = each.value.port
  }
}
