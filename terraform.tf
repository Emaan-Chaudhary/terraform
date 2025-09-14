terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.13.0"
    }
  }

backend "s3" {
  bucket         = "emaan-state-bucket"
  key            = "terraform.tfstate"
  region         = "us-east-2"
  dynamodb_table = "emaan-state-table"
  encrypt        = true
  }
  }