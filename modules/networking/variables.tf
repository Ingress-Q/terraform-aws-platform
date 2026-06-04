variable "vpc_name" {
  type        = string
  default     = "demo-vpc"
  description = "Name of the AWS VPC."
}

variable "vpc_cidr_block" {
  type        = string
  default     = "10.0.0.0/16"
  description = "CIDR block for the VPC."
}

variable "availability_zones" {
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
  description = "Availability zones to use for subnets."
}

variable "public_subnets" {
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  description = "CIDR blocks for public subnets."
}

variable "private_subnets" {
  type        = list(string)
  default     = ["10.0.11.0/24", "10.0.12.0/24", "10.0.13.0/24"]
  description = "CIDR blocks for private subnets."
}
variable "private_db_subnets" {
  type        = list(string)
  default     = ["10.0.21.0/24", "10.0.22.0/24", "10.0.23.0/24"]
  description = "CIDR blocks for private database subnets."
}

variable "enable_dns_hostnames" {
  type        = bool
  default     = true
  description = "Whether to enable DNS hostnames in the VPC."
}

variable "enable_dns_support" {
  type        = bool
  default     = true
  description = "Whether to enable DNS support in the VPC."
}

variable "enable_nat_gateway" {
  type        = bool
  default     = true
  description = "Whether to create NAT gateway(s) for private subnets."
}

variable "single_nat_gateway" {
  type        = bool
  default     = true
  description = "Whether to use a single NAT gateway for all private subnets."
}

variable "name" {
  default = "eks-vpc"
}

variable "tags" {
  type = map(string)
  default = {
    Environment = "dev"
    ManagedBy   = "terraform"
  }
}