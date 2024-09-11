#----------------------------------------------------------#
########   Lambda Function ###########
#----------------------------------------------------------#
data "archive_file" "put_data_to_opensearch_athena_history_zip" {
  type        = "zip"
  source_dir  = "${local.codebase_root_path}/scripts/put_data_to_opensearch_athena_history/pkg"
  output_path = "put_data_to_opensearch_athena_history.zip"
}


resource "aws_lambda_function" "put_data_to_opensearch_athena_history" {
  function_name    = "put_data_to_opensearch_athena_history"
  filename         = "put_data_to_opensearch_athena_history.zip"
  source_code_hash = data.archive_file.put_data_to_opensearch_athena_history_zip.output_base64sha256
  role             = var.LAMBDA_ROLE_ARN
  handler          = "put_data_to_opensearch_athena_history.lambda_handler"
  runtime          = "python3.9"
  timeout          = 800
  environment {
    variables = {
      "REGION"       = var.AWS_REGION
      "HOST"         = aws_opensearch_domain.opensearch_kinesis.endpoint
      "PORT"         = 443
    }
  }

  tags = {
    Name = "Invoke Lambda function"
  }
}


resource "aws_lambda_permission" "lambda_permission"{
  statement_id="AllowS3Invoke"
  action="lambda:InvokeFunction"
  function_name=aws_lambda_function.put_data_to_opensearch_athena_history.function_name
  principal="s3.amazonaws.com"
  source_arn="arn:aws:s3:::kinesis-s3-athena-test"
}

resource "aws_s3_bucket_notification" "s3_trigger"{
  bucket="kinesis-s3-athena-test"
  lambda_function{
    lambda_function_arn=aws_lambda_function.put_data_to_opensearch_athena_history.arn
    events=["s3:ObjectCreated:*"]
    filter_suffix=".csv"
  }
}