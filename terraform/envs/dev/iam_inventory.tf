############################
# IAM Role for Inventory Lambda
############################

resource "aws_iam_role" "inventory_lambda_role" {
  name = "cloudops-inventory-lambda-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Project     = "cloudops-control-plane"
    Environment = "dev"
    Purpose     = "Inventory-Lambda"
    ManagedBy   = "Terraform"
  }
}

############################
# IAM Policy for Inventory Lambda
############################

resource "aws_iam_policy" "inventory_lambda_policy" {
  name        = "cloudops-inventory-lambda-policy"
  description = "Read-only inventory access + S3 write access"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [

      # EC2 & EBS inventory
      {
        Effect = "Allow"
        Action = [
          "ec2:DescribeInstances",
          "ec2:DescribeVolumes",
          "ec2:DescribeSnapshots",
          "ec2:DescribeTags"
        ]
        Resource = "*"
      },

      # IAM inventory (read-only)
      {
        Effect = "Allow"
        Action = [
          "iam:ListUsers",
          "iam:ListRoles",
          "iam:ListPolicies",
          "iam:GetUser",
          "iam:GetRole",
          "iam:GetPolicy"
        ]
        Resource = "*"
      },

      # Write inventory output to S3
      {
        Effect = "Allow"
        Action = [
          "s3:PutObject"
        ]
        Resource = "arn:aws:s3:::cloudops-inventory-dev-027687809970/*"
      }
    ]
  })
}

############################
# Attach policy to role
############################

resource "aws_iam_role_policy_attachment" "inventory_lambda_attach" {
  role       = aws_iam_role.inventory_lambda_role.name
  policy_arn = aws_iam_policy.inventory_lambda_policy.arn
}

############################
# Basic Lambda logging
############################

resource "aws_iam_role_policy_attachment" "inventory_lambda_logs" {
  role       = aws_iam_role.inventory_lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

