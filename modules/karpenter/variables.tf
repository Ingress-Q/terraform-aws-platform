variable "name" {
  default = eks
}
variable "tags" {
  default = { managed_by = "terraform" }
}

variable "project" {
  default = eks-gitops
}
variable "environment" {
  default = dev
}

variable "cluster_name" {
  default = demo-eks-cluster
}
variable "cluster_name" {
  description = "Kubernetes cluster name for karpenter settings"
  type        = string
  default     = ""
}

variable "cluster_endpoint" {
  description = "Kubernetes cluster endpoint for karpenter settings"
  type        = string
  default     = ""
}

variable "interruption_queue" {
  description = "Interruption queue for karpenter settings"
  type        = string
  default     = ""
}