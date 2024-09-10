#----------------------------------------------------------#
########   Lambda Function ###########
#----------------------------------------------------------#
data "archive_file" "get_data_from_kinesis_and_put_to_opensearch_zip" {
  type        = "zip"
  source_dir  = "${local.codebase_root_path}/scripts/get_data_from_kinesis_and_put_to_opensearch/pkg"
  output_path = "get_data_from_kinesis_and_put_to_opensearch.zip"
}


resource "aws_lambda_function" "get_data_from_kinesis_and_put_to_opensearch" {
  function_name    = "get_data_from_kinesis_and_put_to_opensearch"
  filename         = "get_data_from_kinesis_and_put_to_opensearch.zip"
  source_code_hash = data.archive_file.get_data_from_kinesis_and_put_to_opensearch_zip.output_base64sha256
  role             = var.LAMBDA_ROLE_ARN
  handler          = "get_data_from_kinesis_and_put_to_opensearch.lambda_handler"
  runtime          = "python3.9"
  timeout          = 800
  environment {
    variables = {
      "REGION"       = var.AWS_REGION
      "HOST"         = aws_opensearch_domain.opensearch_kinesis.endpoint
      "PORT"         = 443
      "KINESIS_NAME" = aws_kinesis_stream.kinesis_open.name
    }
  }

  tags = {
    Name = "Invoke Lambda function"
  }
}

resource "aws_lambda_event_source_mapping" "kinesis_event_source" {
  event_source_arn=aws_kinesis_stream.kinesis_open.arn
  function_name=aws_lambda_function.get_data_from_kinesis_and_put_to_opensearch.arn
  starting_position="LATEST"
}
