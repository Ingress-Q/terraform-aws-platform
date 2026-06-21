module "alb_controller" {
  source = "../../modules/aws-load-balancer-controller"

  name         = "${var.project_name}-${var.environment}"
  cluster_name = module.eks.cluster_name

  tags = merge(var.tags, { Environment = var.environment })
}