# Terraform providers configuration
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.63"
    }
  }

  required_version = ">= 1.3.0"
}

provider "aws" {
  region = var.AWS_REGION
}

module "terraform_security" {
  source = "./modules/security"
}



module "terraform_resources" {
  source = "./modules/resources"
  depends_on = [
    module.terraform_security
  ]
  MASTER_USER_NAME     = var.MASTER_USER_NAME
  MASTER_USER_PASSWORD = var.MASTER_USER_PASSWORD
  LAMBDA_ROLE_ARN      = module.terraform_security.iam_for_lambda_arn
  EVENT_ROLE_ARN       = module.terraform_security.iam_for_pipes_arn


}
