output "cluster_name" {
  value = aws_eks_cluster.this.name
}

output "cluster_endpoint" {
  value = aws_eks_cluster.this.endpoint
}

output "cluster_arn" {
  value = aws_eks_cluster.this.arn
}

output "pod_identity_role_arn" {
  value = aws_iam_role.pod_identity_role.arn
}
output "node_security_group_id" {
  value = aws_eks_cluster.this.vpc_config[0].cluster_security_group_id
}