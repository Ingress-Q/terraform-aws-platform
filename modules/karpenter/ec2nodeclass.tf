resource "kubectl_manifest" "karpenter_ec2nodeclass" {
  yaml_body = yamlencode({
    apiVersion = "karpenter.k8s.aws/v1"
    kind       = "EC2NodeClass"
    metadata = { name = "default" }
    spec = {
      amiFamily       = "AL2023"
      instanceProfile = aws_iam_instance_profile.karpenter_node.name

      subnetSelectorTerms = [
        for subnet_id in var.private_subnet_ids : { id = subnet_id }
      ]

      securityGroupSelectorTerms = [
        { id = var.cluster_security_group_id }
      ]

      blockDeviceMappings = [
        {
          deviceName = "/dev/xvda"
          ebs = {
            volumeSize          = "30Gi"
            volumeType          = "gp3"
            deleteOnTermination = true
            encrypted            = true
          }
        }
      ]

      tags = merge(var.tags, { Name = "${var.project}-${var.environment}-karpenter-node" })
    }
  })

  depends_on = [aws_iam_instance_profile.karpenter_node]
}