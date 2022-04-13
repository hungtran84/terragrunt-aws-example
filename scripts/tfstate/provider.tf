
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = local.aws_region
  profile = local.aws_profile

  default_tags {
    tags = local.default_tags
  }
}
