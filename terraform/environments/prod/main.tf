terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         = "devawilliams-devopschallenge-terraform-state-ap-south-1"
    key            = "devel/terraform.tfstate"
    region         = "ap-south-1"
    encrypt        = true
    dynamodb_table = "terraform-state-lock"
  }
}

provider "aws" {
  region = var.aws_region
}

# CloudFront + S3 setup using module
module "cloudfront_s3" {
  source       = "../../modules/cloudfront-s3"
  environment  = "devel"
  project_name = var.project_name
  aws_region   = var.aws_region
}

# Add these outputs (used by GitHub Actions)
output "website_bucket_name" {
  value = module.cloudfront_s3.website_bucket_name
}

output "cloudfront_distribution_id" {
  value = module.cloudfront_s3.cloudfront_distribution_id
}

output "cloudfront_domain_name" {
  value = module.cloudfront_s3.cloudfront_domain_name
}
