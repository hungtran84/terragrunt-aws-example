resource "aws_opsworks_stack" "main" {
  name                         = "${var.name}"
  region                       = "${var.region}"
  # color                       = "${var.color}"
  service_role_arn             = "${var.service_role_arn}"
  default_instance_profile_arn = "${var.instance_profile}"
  vpc_id                       = "${var.vpc_id}"
  default_subnet_id            = "${var.default_subnet_id}"
  custom_json                  = "${var.custom_json}"
  default_os                   = "${var.default_os}"
  use_custom_cookbooks         = "${var.use_custom_cookbooks}"
  configuration_manager_version = "${var.configuration_manager_version}"
  dynamic "custom_cookbooks_source" {
    for_each = var.custom_cookbooks_source
    content {
      type = custom_cookbooks_source.value["type"]
      url  = custom_cookbooks_source.value["url"]
      ssh_key = custom_cookbooks_source.value["ssh_key"]
      revision = custom_cookbooks_source.value["revision"]
    }  

  }
}
