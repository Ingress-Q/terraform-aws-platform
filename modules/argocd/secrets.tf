# ArgoCD discovers repo credentials via Secrets labeled
# argocd.argoproj.io/secret-type=repo-creds, matched by URL prefix —
# one secret per Git host/org prefix covers all repos under it.
resource "kubernetes_secret" "repo_creds" {
  metadata {
    name      = "github-repo-creds"
    namespace = "argocd"
    labels = {
      "argocd.argoproj.io/secret-type" = "repo-creds"
    }
  }

  data = {
    type     = "git"
    url      = "https://github.com/Ingress-Q"
    username = "x-access-token"
    password = var.github_pat
  }

  depends_on = [helm_release.argocd]
}