module "argocd" {
  source = "../../modules/argocd"

  github_pat       = var.github_pat
}
