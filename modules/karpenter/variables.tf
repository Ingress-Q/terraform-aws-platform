variable "name" {
  default = eks
}
variable "tags" {
  default = {managed_by = "terraform"}
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
