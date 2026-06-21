terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Environment = "dev"
      ManagedBy   = "Terraform"
      Project     = var.project_name
    }
  }
}
provider "helm" {}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

# Networking Module
module "networking" {
  source = "../../modules/networking"



  tags = {
    Environment = "dev"
    ManagedBy   = "Terraform"
  }
}

# EKS Module
module "eks" {
  source = "../../modules/eks"

  project     = var.project_name
  environment = var.environment
  region      = var.aws_region

  vpc_id             = module.networking.vpc_id
  private_subnet_ids = module.networking.private_subnets_ids
  public_subnet_ids  = module.networking.public_subnets_ids


  tags = {
    Environment = "dev"
    ManagedBy   = "Terraform"
  }
}

# DynamoDB Module
module "dynamodb" {
  source = "../../modules/dynamodb"

  table_name = "cart-items-dev"

  tags = {
    Environment = "dev"
    ManagedBy   = "Terraform"
  }
}

module "catalog_db" {
  source = "../../modules/rds"

  identifier = "catalog-mysql-dev"

  engine            = "mysql"
  engine_version    = "8.0"
  instance_class    = "db.t3.micro"
  allocated_storage = 20

  db_name         = "catalogdb"
  master_username = "catalog_admin"

  port = 3306

  vpc_id     = module.networking.vpc_id
  subnet_ids = module.networking.private_db_subnets_ids

  allowed_security_group_ids = [module.eks.node_security_group_id]

  tags = {
    Environment = "dev"
    Service     = "catalog-service"
  }
}
module "orders_db" {
  source = "../../modules/rds"

  identifier = "orders-postgres-dev"

  engine            = "postgres"
  engine_version    = "17"
  instance_class    = "db.t3.micro"
  allocated_storage = 20

  db_name         = "ordersdb"
  master_username = "orders_admin"

  port = 5432

  vpc_id     = module.networking.vpc_id
  subnet_ids = module.networking.private_db_subnets_ids
  allowed_security_group_ids = [module.eks.node_security_group_id]

  tags = {
    Environment = "dev"
    Service     = "orders-service"
  }
}