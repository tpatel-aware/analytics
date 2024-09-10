resource "aws_athena_workgroup" "athena_workgroup" {
  name        = "test_workgroup"
  description = "Workgroup for testing purposes"
  state       = "ENABLED"

  configuration {
    enforce_workgroup_configuration = false
    requester_pays_enabled          = false
    result_configuration {
      output_location = "s3://${var.APP_S3_BUCKET}/athena_output_bucket/"
    }
  }

  force_destroy = true
  tags = {
    Environment = "Workgroup Testing"
  }
}
