#----------------------------------------------------------#
########   Lambda Function ###########
#----------------------------------------------------------#
data "archive_file" "put_data_to_kinesis_zip" {
  type        = "zip"
  source_dir  = "${local.codebase_root_path}/scripts/put_data_to_kinesis/pkg"
  output_path = "put_data_to_kinesis.zip"
}


resource "aws_lambda_function" "put_data_to_kinesis" {
  function_name    = "put_data_to_kinesis"
  filename         = "put_data_to_kinesis.zip"
  source_code_hash = data.archive_file.put_data_to_kinesis_zip.output_base64sha256
  role             = var.LAMBDA_ROLE_ARN
  handler          = "put_data_to_kinesis.lambda_handler"
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


resource "aws_lambda_permission" "lambda_permission"{
  statement_id="AllowS3Invoke"
  action="lambda:InvokeFunction"
  function_name=aws_lambda_function.put_data_to_kinesis.function_name
  principal="s3.amazonaws.com"
  source_arn="arn:aws:s3:::consolidated-trans-test"
}

resource "aws_s3_bucket_notification" "s3_trigger"{
  bucket="consolidated-trans-test"
  lambda_function{
    lambda_function_arn=aws_lambda_function.put_data_to_kinesis.arn
    events=["s3:ObjectCreated:*"]
    filter_suffix=".json"
  }
}