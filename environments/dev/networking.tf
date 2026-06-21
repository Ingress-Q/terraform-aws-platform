module "networking" {
  source = "../../modules/networking"
  name   = "${var.project_name}-${var.environment}"

  tags = merge(var.tags, { Environment = var.environment })
}