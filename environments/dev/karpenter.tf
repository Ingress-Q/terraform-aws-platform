module "karpenter" {
  source = "../../modules/karpenter"

  name        = "${var.project_name}-${var.environment}"
  project     = var.project_name
  environment = var.environment

  cluster_name     = module.eks.cluster_name
  cluster_endpoint = module.eks.cluster_endpoint

  private_subnet_ids        = module.networking.private_subnets_ids
  cluster_security_group_id = module.eks.node_security_group_id

  interruption_queue = module.karpenter_sqs.queue_name
  node_cpu_limit      = var.karpenter_node_cpu_limit

  tags = merge(var.tags, { Environment = var.environment })
}