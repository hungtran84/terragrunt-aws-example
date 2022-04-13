output "stack_id" {
  description = "The ID of the Opsworks stack"
  value = "${aws_opsworks_stack.main.id}"
}