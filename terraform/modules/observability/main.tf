resource "kubernetes_namespace_v1" "monitoring" {
  metadata {
    name = "monitoring"
  }
}

resource "helm_release" "prometheus_stack" {
  name       = "kube-prometheus-stack"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  namespace  = kubernetes_namespace_v1.monitoring.metadata[0].name
  version    = "72.3.0"

  set_sensitive {
    name  = "grafana.adminPassword"
    value = var.grafana_password
  }

  # Tuned for Pi with 4 GB RAM
  set {
    name  = "prometheus.prometheusSpec.retention"
    value = "7d"
  }

  set {
    name  = "prometheus.prometheusSpec.scrapeInterval"
    value = "30s"
  }
}

resource "helm_release" "loki" {
  name       = "loki"
  repository = "https://grafana.github.io/helm-charts"
  chart      = "loki"
  namespace  = kubernetes_namespace_v1.monitoring.metadata[0].name

  values = [
    file("${path.module}/loki-values.yaml")
  ]
}