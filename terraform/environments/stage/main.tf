terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    bucket         = "devawilliams-devopschallenge-terraform-state"
    key            = "stage/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-state-lock"
  }
}

provider "aws" {
  region = var.aws_region
}

module "cloudfront_s3" {
  source      = "../../modules/cloudfront-s3"
  environment = "stage"
  project_name = var.project_name
  aws_region  = var.aws_region
}
