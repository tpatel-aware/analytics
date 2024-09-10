resource "aws_iam_policy" "ess_opensearch_policy" {
  name   = "ess-opensearch"
  policy = data.template_file.ess_opensearch_policy.rendered
}

resource "aws_iam_policy" "ess_kinesis_policy" {
  name   = "kinesis_policy"
  policy = data.template_file.ess_kinesis_policy.rendered
}

resource "aws_iam_policy" "ess_lambda_policy" {
  name   = "lambda-policy"
  policy = data.template_file.ess_lambda_policy.rendered
}
resource "aws_iam_policy" "ess_pipes_policy" {
  name   = "pipes-policy"
  policy = data.template_file.ess_pipes_policy.rendered
}
