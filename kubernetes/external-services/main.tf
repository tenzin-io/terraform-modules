resource "helm_release" "external_service" {
  for_each         = var.external_services
  repository       = "oci://ghcr.io/tenzin-io"
  chart            = "ingress-external"
  version          = "v0.0.0"
  wait             = true
  name             = "${each.key}-external-service"
  namespace        = var.namespace
  create_namespace = true

  set {
    name  = "certificateIssuerName"
    value = var.cert_issuer_name
  }

  set {
    name  = "serviceName"
    value = "${each.key}-external-service"
  }

  set {
    name  = "originServer.address"
    value = each.value.address
  }

  set {
    name  = "originServer.protocol"
    value = each.value.protocol
  }

  set {
    name  = "originServer.port"
    value = each.value.port
  }

  set {
    name  = "virtualHostFQDN"
    value = each.value.virtual_host
  }

  set {
    name  = "requestSize"
    value = each.value.request_body_size
  }
}

resource "helm_release" "redirect_service" {
  for_each         = var.redirect_services
  repository       = "oci://ghcr.io/tenzin-io"
  chart            = "ingress-redirect"
  version          = "v0.0.0"
  name             = "${each.key}-redirect-service"
  namespace        = var.namespace
  create_namespace = true

  set {
    name  = "certificateIssuerName"
    value = var.cert_issuer_name
  }

  set {
    name  = "serviceName"
    value = "${each.key}-redirect-service"
  }

  set {
    name  = "redirectURL"
    value = each.value.redirect_url
  }

  set {
    name  = "virtualHostFQDN"
    value = each.value.virtual_host
  }
}
