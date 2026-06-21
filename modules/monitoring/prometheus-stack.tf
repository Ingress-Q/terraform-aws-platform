resource "helm_release" "kube_prometheus_stack" {
  name             = "monitoring"
  repository       = "https://prometheus-community.github.io/helm-charts"
  chart            = "kube-prometheus-stack"
  namespace        = "monitoring"
  create_namespace = true
  version          = "66.3.1"

  values = [
    yamlencode({
      prometheus = {
        prometheusSpec = {
          retention = "5d"
          storageSpec = {
            volumeClaimTemplate = {
              spec = {
                storageClassName = "gp3"
                accessModes      = ["ReadWriteOnce"]
                resources = {
                  requests = { storage = "20Gi" }
                }
              }
            }
          }
        }
      }
      grafana = {
        # No persistence for Grafana itself — dashboards are defined as
        # code (provisioned), not clicked together, so losing the UI
        # state on teardown is fine. Only the metric DATA (Prometheus)
        # needs the PVC above.
        persistence = { enabled = false }
        adminPassword = var.grafana_admin_password
      }
      alertmanager = {
        enabled = false # skipping for now — no alert destinations (Slack/PagerDuty) configured yet, adding this with nothing wired to it is dead weight
      }
    })
  ]
}