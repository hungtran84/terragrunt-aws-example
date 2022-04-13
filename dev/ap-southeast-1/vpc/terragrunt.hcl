# ---------------------------------------------------------------------------------------------------------------------
# TERRAGRUNT CONFIGURATION
# This is the configuration for Terragrunt, a thin wrapper for Terraform that helps keep your code DRY and
# maintainable: https://github.com/gruntwork-io/terragrunt
# ---------------------------------------------------------------------------------------------------------------------

# We override the terraform block source attribute here just for the QA environment to show how you would deploy a
# different version of the module in a specific environment.
# terraform {
#   source = "${include.envcommon.locals.base_source_url}?ref=v3.14.0"
# }


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
  path   = "${dirname(find_in_parent_folders())}/_envcommon/vpc.hcl"
  expose = true
}


inputs = {
  cidr = "10.254.0.0/16"
  private_subnets = ["10.254.1.0/24", "10.254.2.0/24", "10.254.3.0/24"]
  public_subnets  = ["10.254.101.0/28", "10.254.102.0/28", "10.254.103.0/28"]

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}