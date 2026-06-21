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
output "cluster_oidc_issuer_url" {
  value = aws_eks_cluster.this.identity[0].oidc[0].issuer
}
output "cluster_certificate_authority_data" {
  description = "Base64-encoded CA certificate, used by kubernetes/helm/kubectl providers to authenticate without a separate data source read"
  value       = aws_eks_cluster.this.certificate_authority[0].data
}