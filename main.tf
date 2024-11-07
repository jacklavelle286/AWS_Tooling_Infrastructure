data "aws_iam_user" "aws_iam_build_user" {
  user_name = "TT_ADO_Deployment_User"
}

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

resource "aws_iam_user_policy_attachment" "aws_iam_tooling_policy_attachment" {
  policy_arn = aws_iam_policy.aws_iam_tooling_policy.arn
  user = data.aws_iam_user.aws_iam_build_user.user_name
}

resource "aws_iam_policy" "aws_iam_tooling_policy" {
  name        = "buildRoleIamPolicy"
  description = "This policy is edited dynamically to assume roles into customer environments to deploy infrastructure as appropriate and is the service connection into Azure DevOps"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["sts:AssumeRole"]
        Effect   = "Allow"
        Resource = var.customer_role_arns
      },
      {
        Action   = [
          "s3:GetObject",
          "s3:ListBucket"
        ]
        Effect   = "Allow"
        Resource = [
          "arn:aws:s3:::${var.backedns3bucketname}",
          "arn:aws:s3:::${var.backedns3bucketname}/*"
        ]
      },
      {
        Action   = [
          "iam:GetUser",
          "iam:ListAttachedUserPolicies"
        ]
        Effect   = "Allow"
        Resource = data.aws_iam_user.aws_iam_build_user.arn
      },
      {
        Action   = [
          "iam:GetPolicy",
          "iam:GetPolicyVersion",
          "iam:ListPolicyVersions"
        ]
        Effect   = "Allow"
        Resource = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:policy/buildRoleIamPolicy"
      }
    ]
  })
}
