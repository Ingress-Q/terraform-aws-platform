locals {
  cluster_name = "${var.project}-${var.environment}"
  name = "${local.cluster_name}-pod-identity"
}