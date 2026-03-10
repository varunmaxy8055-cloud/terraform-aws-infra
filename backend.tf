terraform {

  backend "s3" {
    bucket = "terraform-state-varun-infra"
    key    = "terraform/state.tfstate"
    region = "ap-south-1"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}