resource "aws_iam_role" "karpenter_node_role" {
  name               = "${var.name}-karpenter-node-role"
  assume_role_policy = jsondecode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "pod.eks.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
  tags = merge(
    var.tags,
    {
      Name = "${var.name}-karpenter-node-role"
    }
  )
}


#controller policy
resource "aws_iam_policy" "karpenter_controller"{
    name = "${var.name}-karpenter-controller-policy"
    description = "Policy for Karpenter Controller"
    policy = jsonencode({
        Version = "2012-10-17",
        Statement = [
            {
                Effect = "Allow",
                Action = [
                     "ec2:CreateFleet",
          "ec2:RunInstances",
          "ec2:CreateLaunchTemplate",
          "ec2:DescribeInstances",
          "ec2:DescribeLaunchTemplates",
          "ec2:DescribeSubnets",
          "ec2:DescribeSecurityGroups",
          "ec2:TerminateInstances",
          "ec2:DescribeInstanceTypes",
          "pricing:GetProducts",
          "ssm:GetParameter",
          "iam:PassRole",
          "eks:DescribeCluster"
                ],
                Resource = "*"
            }
        ]
    })      

}


#controller policy attachment   
resource "aws_iam_role_policy_attachment" "karpenter_controller_attachment" {
  role       = aws_iam_role.karpenter_node_role.name
  policy_arn = aws_iam_policy.karpenter_controller.arn
}


#node iam role
resource "aws_iam_role" "karpenter_node" {
  name = "${var.project}-${var.environment}-karpenter-node"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "worker_node" {
  role       = aws_iam_role.karpenter_node.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role_policy_attachment" "cni" {
  role       = aws_iam_role.karpenter_node.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

resource "aws_iam_role_policy_attachment" "ecr" {
  role       = aws_iam_role.karpenter_node.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}