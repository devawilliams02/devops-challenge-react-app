# Variables for the cloudfront-s3 module
variable "environment" {
  type        = string
  description = "Environment name"
}

variable "project_name" {
  type        = string
  description = "Project name"
}

variable "aws_region" {
  type        = string
  description = "AWS region"
}
