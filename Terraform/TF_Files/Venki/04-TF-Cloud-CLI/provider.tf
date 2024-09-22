terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "remote" {
    organization = "techlearnings-org"

    workspaces {
      name = "TF_CLI"
    }
  }
}

provider "aws" {
  region = var.aws_region
}
