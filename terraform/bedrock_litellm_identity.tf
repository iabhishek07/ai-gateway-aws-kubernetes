
data "aws_caller_identity" "current" {}

data "aws_partition" "current" {}

locals {
  bedrock_inference_profile_arn = "arn:${data.aws_partition.current.partition}:bedrock:${var.aws_region}:${data.aws_caller_identity.current.account_id}:inference-profile/us.amazon.nova-2-lite-v1:0"

  bedrock_model_arns = [
    "arn:${data.aws_partition.current.partition}:bedrock:us-east-1::foundation-model/amazon.nova-2-lite-v1:0",
    "arn:${data.aws_partition.current.partition}:bedrock:us-east-2::foundation-model/amazon.nova-2-lite-v1:0",
    "arn:${data.aws_partition.current.partition}:bedrock:us-west-2::foundation-model/amazon.nova-2-lite-v1:0",
  ]
}

resource "aws_iam_role" "litellm_bedrock" {
  name = "${var.project_name}-litellm-bedrock"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "pods.eks.amazonaws.com"
        }
        Action = [
          "sts:AssumeRole",
          "sts:TagSession"
        ]
      }
    ]
  })

  tags = {
    Project = var.project_name
    Purpose = "LiteLLM Bedrock access"
  }
}

resource "aws_iam_policy" "litellm_bedrock" {
  name        = "${var.project_name}-litellm-bedrock"
  description = "Allow LiteLLM to invoke the Nova 2 Lite inference profile"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "InvokeNova2Lite"
        Effect = "Allow"
        Action = [
          "bedrock:InvokeModel",
          "bedrock:InvokeModelWithResponseStream"
        ]
        Resource = concat(
          [local.bedrock_inference_profile_arn],
          local.bedrock_model_arns
        )
      }
    ]
  })

  tags = {
    Project = var.project_name
  }
}

resource "aws_iam_role_policy_attachment" "litellm_bedrock" {
  role       = aws_iam_role.litellm_bedrock.name
  policy_arn = aws_iam_policy.litellm_bedrock.arn
}

resource "aws_eks_pod_identity_association" "litellm" {
  cluster_name    = var.cluster_name
  namespace       = "ai-gateway"
  service_account = "litellm"
  role_arn        = aws_iam_role.litellm_bedrock.arn

  depends_on = [
    aws_iam_role_policy_attachment.litellm_bedrock
  ]
}

