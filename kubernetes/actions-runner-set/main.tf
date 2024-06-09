terraform {
  required_version = "~> 1.0"
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.0"
    }
  }
}

resource "helm_release" "actions_runner_set" {
  for_each = toset(var.github_config_urls)
  name             = "arc-runner-set-${var.runner_set_name}-${md5(each.key)}"
  namespace        = var.namespace
  create_namespace = true
  repository       = "oci://ghcr.io/actions/actions-runner-controller-charts"
  chart            = "gha-runner-scale-set"
  version          = "0.9.2"

  set {
    name  = "githubConfigUrl"
    value = each.key
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

  set {
    name  = "template.spec.containers[0].name"
    value = "runner"
  }

  set {
    name  = "template.spec.containers[0].command[0]"
    value = "/home/runner/run.sh"
  }

  set {
    name  = "template.spec.containers[0].image"
    value = var.runner_image
  }

}