variable "name" {
  description = "The name of the stack"
  type        = string
}

variable "color" {
  description = "Color to paint next to the stack's resources in the OpsWorks console."
  type        = string
  default     = "blue"
}

variable "region" {
  description = "The name of the region where the stack will exist"
  type        = string
}
variable "service_role_arn" {
  description = "The ARN of an IAM role that the OpsWorks service will act as"
  type        = string
}
variable "instance_profile" {
  description = "The ARN of an IAM Instance Profile that created instances will have by default."
  type        = string
}
variable "vpc_id" {
  description = "The id of the VPC that this stack belongs to."
  type        = string
}
variable "custom_json" {
  description = "Custom JSON attributes to apply to the entire stack."
  type        = string
  default     = ""
}
variable "default_subnet_id" {
  description = " Id of the subnet in which instances will be created by default. Mandatory if vpc_id is set, and forbidden if it isn't."
  type        = string
}
variable "default_os" {
  description = "Name of OS that will be installed on instances by default"
  type        = string
}


variable "use_custom_cookbooks" {
  description = "Boolean value controlling whether the custom cookbook settings are enabled."
  type        = bool
  default     = false
}

variable "custom_cookbooks_source" {
  type = map(string)
  default = {
    type = "git"
    url = ""
    ssh_key = ""
    revision = ""
  }
}

variable "configuration_manager_version" {
  description = "Version of the configuration manager to use"
  type        = number
}