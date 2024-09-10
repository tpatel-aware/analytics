resource "aws_opensearch_domain" "opensearch_kinesis" {
  domain_name    = "opensearch-kinesis"
  engine_version = "OpenSearch_2.13"
  access_policies = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : "*"
        },
        "Action" : "es:*",
        "Resource" : "*"
      }
    ]
  })
  cluster_config {
    instance_type = "i3.2xlarge.search"
  }

  node_to_node_encryption {
    enabled = true
  }

  encrypt_at_rest {
    enabled = true
  }
  advanced_security_options {
    enabled                        = true
    internal_user_database_enabled = true

    master_user_options {
      master_user_name     = var.MASTER_USER_NAME
      master_user_password = var.MASTER_USER_PASSWORD
    }
  }


  domain_endpoint_options {
    enforce_https       = true
    tls_security_policy = "Policy-Min-TLS-1-2-2019-07"
  }

  tags = {
    Name = "opensearch_kinesis_domain"
  }
}


