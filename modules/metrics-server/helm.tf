terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.13"
    }
  }
}

# metrics-server powers `kubectl top` and is the data source HPA uses to
# make scaling decisions. Without it, any HorizontalPodAutoscaler you
# define on the microservices will sit with <unknown> metrics and never
# actually scale.
resource "helm_release" "metrics_server" {
  name       = "metrics-server"
  repository = "https://kubernetes-sigs.github.io/metrics-server/"
  chart      = "metrics-server"
  namespace  = "kube-system"
  version    = "3.12.2"

  set {
    name  = "args[0]"
    value = "--kubelet-insecure-tls"
  }
}