resource "helm_release" "argocd" {
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = "argocd"
  create_namespace = true
  version          = "7.7.11"

  values = [
    yamlencode({
      server = {
        # No custom domain available — service stays ClusterIP, accessed
        # via kubectl port-forward for now. Switch to LoadBalancer/Ingress
        # once a domain + ALB Controller wiring is in place.
        service = {
          type = "ClusterIP"
        }
      }
    })
  ]
}

# App-of-apps: a single ArgoCD Application that points at your existing
# gitops-platform repo. ArgoCD then manages everything else (the 5
# microservices) FROM that repo — this is the one resource Terraform
# needs to create; ArgoCD takes over from here via GitOps, not Terraform.
resource "kubectl_manifest" "root_app" {
  yaml_body = yamlencode({
    apiVersion = "argoproj.io/v1alpha1"
    kind       = "Application"
    metadata = {
      name      = "root-app"
      namespace = "argocd"
    }
    spec = {
      project = "default"
      source = {
        repoURL        = "https://github.com/Ingress-Q/gitops-platform.git"
        targetRevision = "main"
        path           = "applications"
      }
      destination = {
        server    = "https://kubernetes.default.svc"
        namespace = "argocd"
      }
      syncPolicy = {
        automated = {
          prune    = true
          selfHeal = true
        }
      }
    }
  })

  depends_on = [
    helm_release.argocd,
    kubernetes_secret.repo_creds
  ]
}