resource "kubectl_manifest" "karpenter_nodepool" {
  yaml_body = yamlencode({
    apiVersion = "karpenter.sh/v1"
    kind       = "NodePool"
    metadata   = { name = "default" }
    spec = {
      template = {
        spec = {
          nodeClassRef = {
            group = "karpenter.k8s.aws"
            kind  = "EC2NodeClass"
            name  = "default"
          }
          requirements = [
            { key = "karpenter.sh/capacity-type", operator = "In", values = var.capacity_types },
            { key = "karpenter.k8s.aws/instance-category", operator = "In", values = var.instance_categories },
            { key = "karpenter.k8s.aws/instance-generation", operator = "Gt", values = ["2"] },
            { key = "kubernetes.io/arch", operator = "In", values = ["amd64"] }
          ]
        }
      }
      limits = { cpu = var.node_cpu_limit }
      disruption = {
        consolidationPolicy = "WhenEmptyOrUnderutilized"
        consolidateAfter    = "1m"
      }
    }
  })

  depends_on = [kubectl_manifest.karpenter_ec2nodeclass]
}