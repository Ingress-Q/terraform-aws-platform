module "external_secrets" {
  source = "../../modules/external-secrets"

  name         = "${var.project_name}-${var.environment}"
  project      = var.project_name
  environment  = var.environment
  cluster_name = module.eks.cluster_name
  region       = var.aws_region

  secret_arns = [
    module.catalog_db.master_user_secret_arn,
    module.orders_db.master_user_secret_arn
  ]

  tags = merge(var.tags, { Environment = var.environment })
}