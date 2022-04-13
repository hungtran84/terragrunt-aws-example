# Terraform still needs an AWS region to send API request to, even for resources that don't live in a specific region, so we just pick some reasonable default for the _global region.
locals {
  aws_region = "ap-southeast-1"
}