resource "aws_lambda_function" "inventory" {
  function_name = "cloudops-inventory-lambda"
  role          = aws_iam_role.inventory_lambda_role.arn
  handler       = "inventory_collector.lambda_handler"
  runtime       = "python3.12"
  timeout       = 300

  filename         = "../../../lambdas/inventory_collector.zip"
source_code_hash = filebase64sha256("../../../../lambdas/inventory_collector.zip")

  environment {
    variables = {
      INVENTORY_BUCKET = "cloudops-inventory-dev-027687809970"
    }
  }
}

