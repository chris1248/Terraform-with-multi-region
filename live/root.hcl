locals {
  aws_region = get_env("AWS_REGION")
}

generate "terraform" {
  path = "terraform.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 4.11.0"
    }
  }
  required_version = ">= 1.0.9"
}

provider "aws" {
  region = "${local.aws_region}"
}

EOF
}

