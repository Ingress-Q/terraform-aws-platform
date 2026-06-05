resource "aws_eks_pod_identity_association" "karpenter" {
  cluster_name    = var.cluster_name
  namespace       = "karpenter"
  service_account = "karpenter"

  role_arn = aws_iam_role.karpenter_controller.arn
}