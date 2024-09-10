output "iam_for_open_search_arn" {
  value = aws_iam_role.ess_opensearch_role.arn
}
output "iam_for_lambda_arn" {
  value = aws_iam_role.ess_lambda_role.arn
}
output "iam_for_pipes_arn" {
  value = aws_iam_role.ess_pipes_role.arn
}
