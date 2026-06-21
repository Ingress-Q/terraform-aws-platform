# DynamoDB Module
module "dynamodb" {
  source = "../../modules/dynamodb"

  table_name = "cart-items-${var.environment}"
  hash_key   = "customerId"
  range_key  = "itemId"

  tags = merge(var.tags, { Environment = var.environment })
}

# Catalog DB (MySQL)
module "catalog_db" {
  source = "../../modules/rds"

  identifier        = "catalog-mysql-${var.environment}"
  engine            = "mysql"
  engine_version    = "8.0"
  instance_class    = "db.t3.micro"
  allocated_storage = 20
  db_name           = "catalogdb"
  master_username   = "catalog_admin"
  port              = 3306

  vpc_id     = module.networking.vpc_id
  subnet_ids = module.networking.private_db_subnets_ids

  allowed_security_group_ids = [module.eks.node_security_group_id]

  tags = merge(var.tags, { Environment = var.environment, Service = "catalog-service" })
}

# Orders DB (PostgreSQL)
module "orders_db" {
  source = "../../modules/rds"

  identifier        = "orders-postgres-${var.environment}"
  engine            = "postgres"
  engine_version    = "17"
  instance_class    = "db.t3.micro"
  allocated_storage = 20
  db_name           = "ordersdb"
  master_username   = "orders_admin"
  port              = 5432

  vpc_id     = module.networking.vpc_id
  subnet_ids = module.networking.private_db_subnets_ids

  allowed_security_group_ids = [module.eks.node_security_group_id]

  tags = merge(var.tags, { Environment = var.environment, Service = "orders-service" })
}