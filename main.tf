terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "remote" {
         organization = "Mahen-AWS"
         workspaces {
           name = "mahen-infra"
         }
       }
}

provider "aws" {
  # Configuration options
  region = var.aws_region
}

data "aws_ssm_parameter" "amzn2_linux" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

resource "null_resource" "example" {
  triggers = {
    value = "A example resource that does nothing!"
    }
  }

