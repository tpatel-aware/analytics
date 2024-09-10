data "template_file" "ess_opensearch_policy" {
  template = file("${path.module}/policy_json/opensearch.json")
}

data "aws_iam_policy_document" "assume_opensearch_role" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["es.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

data "template_file" "ess_pipes_policy" {
  template = file("${path.module}/policy_json/pipes.json")
}

data "aws_iam_policy_document" "assume_pipes_role" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["pipes.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

data "template_file" "ess_kinesis_policy" {
  template = file("${path.module}/policy_json/kinesis.json")
}

data "aws_iam_policy_document" "assume_kinesis_role" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["kinesis.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

data "template_file" "ess_lambda_policy" {
  template = file("${path.module}/policy_json/lambda.json")
}

data "aws_iam_policy_document" "assume_lambda_role" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

