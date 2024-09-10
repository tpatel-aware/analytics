resource "aws_iam_role" "ess_opensearch_role" {
  name               = "ess-opensearch"
  assume_role_policy = data.aws_iam_policy_document.assume_opensearch_role.json
}

resource "aws_iam_role_policy_attachment" "ess_opensearch_attachment" {
  role       = aws_iam_role.ess_opensearch_role.name
  policy_arn = aws_iam_policy.ess_opensearch_policy.arn
}

resource "aws_iam_role" "ess_kinesis_role" {
  name               = "kinesis_role"
  assume_role_policy = data.aws_iam_policy_document.assume_kinesis_role.json
}

resource "aws_iam_role_policy_attachment" "ess_kinesis_attachment" {
  role       = aws_iam_role.ess_kinesis_role.name
  policy_arn = aws_iam_policy.ess_kinesis_policy.arn
}

resource "aws_iam_role" "ess_lambda_role" {
  name               = "lambda_role"
  assume_role_policy = data.aws_iam_policy_document.assume_lambda_role.json
}

resource "aws_iam_role_policy_attachment" "ess_lambda_attachment" {
  role       = aws_iam_role.ess_lambda_role.name
  policy_arn = aws_iam_policy.ess_lambda_policy.arn
}

resource "aws_iam_role" "ess_pipes_role" {
  name               = "pipes_role"
  assume_role_policy = data.aws_iam_policy_document.assume_pipes_role.json
}

resource "aws_iam_role_policy_attachment" "ess_pipes_attachment" {
  role       = aws_iam_role.ess_pipes_role.name
  policy_arn = aws_iam_policy.ess_pipes_policy.arn
}
