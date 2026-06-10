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

  project            = var.project_name
  environment        = var.environment
  region             = var.aws_region

  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
  public_subnet_ids  = module.vpc.public_subnet_ids


  tags = {
    Environment = "dev"
    ManagedBy   = "Terraform"
  }
}
