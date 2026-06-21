resource "helm_release" "otel_collector" {
  name             = "otel-collector"
  repository       = "https://open-telemetry.github.io/opentelemetry-helm-charts"
  chart            = "opentelemetry-collector"
  namespace        = "monitoring"
  create_namespace = true
  version          = "0.108.0"

  values = [
    yamlencode({
      mode = "deployment"
      config = {
        receivers = {
          otlp = {
            protocols = {
              grpc = { endpoint = "0.0.0.0:4317" }
              http = { endpoint = "0.0.0.0:4318" }
            }
          }
        }
        exporters = {
          prometheus = {
            endpoint = "0.0.0.0:8889"
          }
        }
        service = {
          pipelines = {
            metrics = {
              receivers = ["otlp"]
              exporters = ["prometheus"]
            }
            traces = {
              receivers = ["otlp"]
              exporters = ["debug"] # placeholder until a trace backend (e.g. Tempo) is added
            }
          }
        }
      }
    })
  ]

  depends_on = [helm_release.kube_prometheus_stack]
}