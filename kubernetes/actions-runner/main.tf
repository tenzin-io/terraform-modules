terraform {
  required_version = "~> 1.0"
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.0"
    }
  }
}

resource "helm_release" "actions_runner_controller" {
  name             = "arc"
  namespace        = var.namespace
  create_namespace = true
  repository       = "oci://ghcr.io/actions/actions-runner-controller-charts"
  chart            = "gha-runner-scale-set-controller"
  version          = "0.9.2"
}

resource "helm_release" "actions_runner_set" {
  depends_on       = [helm_release.actions_runner_controller]
  name             = "arc-runner-set"
  namespace        = var.namespace
  create_namespace = true
  repository       = "oci://ghcr.io/actions/actions-runner-controller-charts"
  chart            = "gha-runner-scale-set"
  version          = "0.9.2"

  set {
    name  = "githubConfigUrl"
    value = var.github_org_url
  }

  set {
    name  = "githubConfigSecret.github_app_id"
    value = var.github_app_id
  }

  set {
    name  = "githubConfigSecret.github_app_installation_id"
    value = var.github_app_installation_id
  }

  set {
    name  = "githubConfigSecret.github_app_private_key"
    value = var.github_app_private_key
  }

  set {
    name  = "runnerScaleSetName"
    value = var.runner_set_name
  }

  set {
    name  = "minRunners"
    value = var.minimum_runners
  }

  set {
    name  = "maxRunners"
    value = var.maximum_runners
  }
}