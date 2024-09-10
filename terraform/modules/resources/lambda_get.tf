#----------------------------------------------------------#
########   Lambda Function ###########
#----------------------------------------------------------#
data "archive_file" "get_data_from_opensearch_zip" {
  type        = "zip"
  source_dir  = "${local.codebase_root_path}/scripts/get_data_from_opensearch/pkg"
  output_path = "get_data_from_opensearch.zip"
}


resource "aws_lambda_function" "get_data_from_opensearch" {
  function_name    = "get_data_from_opensearch"
  filename         = "get_data_from_opensearch.zip"
  source_code_hash = data.archive_file.get_data_from_opensearch_zip.output_base64sha256
  role             = var.LAMBDA_ROLE_ARN
  handler          = "get_data_from_opensearch.lambda_handler"
  runtime          = "python3.9"
  timeout          = 800
  environment {
    variables = {
      "REGION" = var.AWS_REGION
      "HOST"   = aws_opensearch_domain.opensearch_kinesis.endpoint
      "PORT"   = 443
    }
  }

  tags = {
    Name = "Invoke Lambda function"
  }
}
