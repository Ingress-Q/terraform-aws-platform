module "eks" {
  source = "../../modules/eks"

  project     = var.project_name
  environment = var.environment
  region      = var.aws_region

  vpc_id             = module.networking.vpc_id
  private_subnet_ids = module.networking.private_subnets_ids
  public_subnet_ids  = module.networking.public_subnets_ids

  cluster_version  = var.cluster_version
  instance_types   = var.instance_types
  desired_size     = var.desired_size
  min_size         = var.min_size
  max_size         = var.max_size
  api_access_cidrs = var.eks_api_access_cidrs

  tags = merge(var.tags, { Environment = var.environment })
}