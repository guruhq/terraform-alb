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
variable "deregistration_delay" {
  default = 300
}
variable "healthy_threshold" {
  default = 3
}
variable "unhealthy_threshold" {
  default = 2
}
variable "interval" {
  default = 5
}
variable "timeout" {
  default = 4
}
variable "slow_start" {
  default = 0
}
variable "access_logs_bucket" {
  deafult = "guru-access-logs"
}
variable "access_logs_enabled" {
  default = "false"
}
