module "karpenter_sqs" {
  source = "../../modules/sqs"

  queue_name = "${var.project_name}-${var.environment}-karpenter-interrupt"
  tags       = merge(var.tags, { Environment = var.environment })
}