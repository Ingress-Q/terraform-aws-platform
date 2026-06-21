

resource "aws_iam_role" "pod_identity_role" {

  name = "${local.name}-pod-identity-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [{
      Effect = "Allow"

      Principal = {
        Service = "pods.eks.amazonaws.com"
      }

      Action = [
        "sts:AssumeRole",
        "sts:TagSession"
      ]
    }]
  })
}
resource "aws_iam_policy" "pod_identity_policy" {

  name = "${local.name}-pod-identity-policy"

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [{
      Effect = "Allow"

      Action = [
        "s3:ListBucket"
      ]

      Resource = "*"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "pod_identity_attach" {

  role       = aws_iam_role.pod_identity_role.name

  policy_arn = aws_iam_policy.pod_identity_policy.arn
}