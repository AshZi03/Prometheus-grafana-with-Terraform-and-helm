resource "helm_release" "grafana" {
  depends_on = [kubernetes_namespace.monitoring]
  name       = "grafana"
  repository = "https://grafana.github.io/helm-charts"
  chart      = "grafana"
  namespace  = kubernetes_namespace.monitoring.id
  version    = "6.51.5"

  set {
    name  = "adminPassword"
    value = "admin"  # Change this to your desired admin password
  }

  set {
    name  = "persistence.enabled"
    value = "false"  # Set to "false" to disable persistence
  }

  set {
    name  = "service.type"
    value = "LoadBalancer"  # Service type for external access
  }

  set {
    name  = "readinessProbe.enabled"
    value = "true"  # Enable readiness probe
  }

  set {
    name  = "readinessProbe.httpGet.path"
    value = "/api/health"  # Path for the readiness probe
  }

  set {
    name  = "readinessProbe.httpGet.port"
    value = "3000"  # Port for the readiness probe
  }

  set {
    name  = "readinessProbe.initialDelaySeconds"
    value = "30"  # Delay before the readiness probe is initiated
  }

  set {
    name  = "readinessProbe.periodSeconds"
    value = "10"  # How often to perform the readiness probe
  }

  set {
    name  = "readinessProbe.timeoutSeconds"
    value = "5"  # Time to wait for a response
  }

  set {
    name  = "readinessProbe.successThreshold"
    value = "1"  # Minimum consecutive successes for the probe to be considered successful
  }

  set {
    name  = "readinessProbe.failureThreshold"
    value = "3"  # Minimum consecutive failures for the probe to be considered failed
  }
}
