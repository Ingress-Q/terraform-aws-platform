locals {
  cluster_name = "${var.project}-${var.environment}-${var.region}"

  common_tags = merge(
    var.tags,
    {
      Environment = var.environment
      ManagedBy   = "Terraform"
    }
  )
}