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

  depends_on = [kubernetes_config_map_v1.time_slicing_config]
}

resource "kubernetes_config_map_v1" "time_slicing_config" {
  metadata {
    name      = "time-slicing-config"
    namespace = var.namespace
  }

  data = {
    any = yamlencode(<<-EOT
      version: v1
      flags:
        migStrategy: none
      sharing:
        timeSlicing:
          renameByDefault: false
          failRequestsGreaterThanOne: false
          resources:
            - name: nvidia.com/gpu
              replicas: ${var.gpu_slices}
    EOT
    )
  }
}