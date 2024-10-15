resource "helm_release" "prometheus" {
  depends_on = [kubernetes_namespace.monitoring]
  name       = "prometheus"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  namespace  = kubernetes_namespace.monitoring.id
  version    = "45.7.1"

  values = [
    file("values.yaml")  # Your custom values for Prometheus
  ]

  set {
    name  = "podSecurityPolicy.enabled"
    value = true
  }

  set {
    name  = "service.type"
    value = "LoadBalancer"  # Set to LoadBalancer for external access
  }

  set {
    name  = "service.annotations"
    value = yamlencode({
      "service.beta.kubernetes.io/aws-load-balancer-type" = "nlb"  # Use NLB or "classic" for ELB
    })
  }

  set {
    name  = "server.persistentVolume.enabled"
    value = false
  }

  set {
    name = "server.resources"
    value = yamlencode({
      limits = {
        cpu    = "200m"
        memory = "50Mi"
      }
      requests = {
        cpu    = "100m"
        memory = "30Mi"
      }
    })
  }
}
