resource "helm_release" "karpenter" {
  count = 0 # disabled for now

  name       = "karpenter"
  repository = "oci://public.ecr.aws/karpenter"
  chart      = "karpenter"
  namespace  = "karpenter"

  values = [
    <<EOF
settings:
  clusterName: "${var.cluster_name}"
  clusterEndpoint: "${var.cluster_endpoint}"
  interruptionQueue: "${var.interruption_queue}"
EOF
  ]
}

