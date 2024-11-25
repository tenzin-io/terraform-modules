output "prometheus_url" {
  value = "http://prometheus-kube-prometheus-prometheus.${var.namespace}.svc.cluster.local:9090"
}