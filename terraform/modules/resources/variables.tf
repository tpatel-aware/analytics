variable "AWS_REGION" {
  type        = string
  description = "AWS region"
  default     = "us-east-1"
}

variable "LAMBDA_ROLE_ARN" {
  type        = string
  description = "Lambda IAM role ARN"
}
variable "EVENT_ROLE_ARN" {
  type        = string
  description = "EVENT IAM role ARN"
  default     = "value"
}



variable "MASTER_USER_NAME" {
  type        = string
  description = "master user name for opensearch"
  sensitive   = true
}

variable "MASTER_USER_PASSWORD" {
  type        = string
  description = "master user password for oppensearch"
  sensitive   = true
}


variable "APP_S3_BUCKET" {
  type        = string
  description = "bucket name for output"
  default     = "kinesis-s3-athena-test"
}

variable "S3_PREFIX" {
  description = "The prefix in the S3 bucket where the data is located"
  type        = string
  default     = "glue_table"
}
