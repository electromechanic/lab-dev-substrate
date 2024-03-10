provider "aws" {
  region = "us-east-1"
  default_tags {
    tags = {
      environment = "dev"
      project     = "lab"
    }
  }
}

terraform {
  backend "s3" {
    bucket = "lab-dev-us-east-1-state"
    key    = "lab/dev/us-east-1/substrate/terraform.tfstate"
    region = "us-east-1"
  }
}

module "vpc-us-east-1" {
  source   = "git@github.com:electromechanic/terraform-module-aws-vpc.git"
  customer = "lab"

  cidr_block  = "10.3.0.0/16"
  environment = "dev"

  nat_gw                   = false
  endpoint_ecr             = true
  endpoint_secrets_manager = false
}
