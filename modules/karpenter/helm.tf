resource "helm_release" "karpenter" {
  name       = "karpenter"
  repository = "oci://public.ecr.aws/karpenter"
  chart      = "karpenter"
  namespace  = "karpenter"
  create_namespace = true
  version    = "1.1.1"

  values = [
    <<EOF
settings:
  clusterName: "${var.cluster_name}"
  clusterEndpoint: "${var.cluster_endpoint}"
  interruptionQueue: "${var.interruption_queue}"
EOF
  ]

  depends_on = [
    aws_eks_pod_identity_association.karpenter
  ]
}