variable "name" {
  type    = string
  default = "eks"
}

variable "project" {
  type    = string
  default = "eks-gitops"
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "cluster_name" {
  type = string
}

variable "cluster_endpoint" {
  type = string
}

variable "interruption_queue" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "cluster_security_group_id" {
  type = string
}

variable "capacity_types" {
  type    = list(string)
  default = ["spot", "on-demand"]
}

variable "instance_categories" {
  type    = list(string)
  default = ["c", "m", "r"]
}

variable "node_cpu_limit" {
  type    = string
  default = "16"
}

variable "tags" {
  type    = map(string)
  default = { managed_by = "terraform" }
}