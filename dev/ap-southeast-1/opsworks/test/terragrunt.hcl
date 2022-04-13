# ---------------------------------------------------------------------------------------------------------------------
# TERRAGRUNT CONFIGURATION
# This is the configuration for Terragrunt, a thin wrapper for Terraform that helps keep your code DRY and
# maintainable: https://github.com/gruntwork-io/terragrunt
# ---------------------------------------------------------------------------------------------------------------------

# We override the terraform block source attribute here just for the QA environment to show how you would deploy a
# different version of the module in a specific environment.
terraform {
  source = "${include.envcommon.locals.base_source_url}"
}

locals {
  # Automatically load environment-level variables
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))

  # Automatically load region-level variables
  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))

  # Extract the variables we need for easy access
  env = local.environment_vars.locals.environment
  region   = local.region_vars.locals.aws_region
}


# ---------------------------------------------------------------------------------------------------------------------
# Include configurations that are common used across multiple environments.
# ---------------------------------------------------------------------------------------------------------------------

# Include the root `terragrunt.hcl` configuration. The root configuration contains settings that are common across all
# components and environments, such as how to configure remote state.
include "root" {
  path = find_in_parent_folders()
}

# Include the envcommon configuration for the component. The envcommon configuration contains settings that are common
# for the component across all environments.
include "envcommon" {
  path   = "${dirname(find_in_parent_folders())}/_envcommon/opsworks/opsworks_stack.hcl"
  expose = true
}


dependency "opsworks-role" {
  config_path = "${get_terragrunt_dir()}/../../../_global/iam/roles/opswork-service-role"
}

dependency "ec2-role" {
  config_path = "${get_terragrunt_dir()}/../../../_global/iam/roles/instance-profile"
}

dependency "vpc" {
  config_path = "${get_terragrunt_dir()}/../../vpc"
}

inputs = {
  name = "${local.env}-test-${local.region}"
  service_role_arn = dependency.opsworks-role.outputs.iam_role_arn
  vpc_id = dependency.vpc.outputs.vpc_id
  default_subnet_id = dependency.vpc.outputs.private_subnets[0]
  instance_profile = dependency.ec2-role.outputs.iam_instance_profile_arn
  use_custom_cookbooks = false
  custom_cookbooks_source = {}
}