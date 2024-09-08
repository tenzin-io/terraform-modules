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

resource "helm_release" "nvidia_gpu_operator_config" {
  name             = "nvidia-config"
  namespace        = var.namespace
  create_namespace = false
  repository       = "oci://ghcr.io/tenzin-io"
  chart            = "nvidia-gpu-operator-config"
  version          = "v0.0.0"
  wait             = true

  set {
    name  = "gpu_slices"
    value = var.gpu_slices
  }
}

resource "helm_release" "nvidia_gpu_operator" {
  name             = "nvidia"
  chart            = "gpu-operator"
  version          = "v24.6.1"
  repository       = "https://helm.ngc.nvidia.com/nvidia"
  create_namespace = true
  namespace        = var.namespace

  set {
    name  = "driver.enabled"
    value = false
  }

  set {
    name  = "devicePlugin.config.name"
    value = "time-slicing-config"
  }

  set {
    name  = "devicePlugin.config.default"
    value = "any"
  }

  depends_on = [helm_release.nvidia_gpu_operator_config]
}