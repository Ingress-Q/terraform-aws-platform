module "checkout_cache" {
  source = "../../modules/elasticache"

  identifier = "checkout-redis-${var.environment}"
  node_type  = "cache.t3.micro"

  vpc_id     = module.networking.vpc_id
  subnet_ids = module.networking.private_db_subnets_ids

  allowed_security_group_ids = [module.eks.node_security_group_id]

  tags = merge(var.tags, { Environment = var.environment, Service = "checkout-service" })
}