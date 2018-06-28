variable "vpc_id" {}
variable "task_definition" {}
variable "project" {}
variable "port" {}
variable "lb_port" {}
variable "cluster_name" {}
variable "environment" {}
variable "health_check_path" {}
variable "lb_security_groups" {
  type = "list"
}
variable "lb_internal_bool" {
  default = "true"
}
variable "region" {
  default = "us-west-2"
}
variable "public_subnet_ids" {
  type    = "list"
}
variable "target_type" {
  default = "instance"
}
variable "hc_matchers" {
  default = "200,404"
}
