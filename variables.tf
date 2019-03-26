variable "profile" {
  default = "default"
}
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
  default = "guru-access-logs"
}
variable "access_logs_enabled" {
  default = "false"
}
variable "certificate_arn" {
  default = "arn:aws:acm:us-west-2:495243515911:certificate/a7b25b53-cf9c-4e16-8e25-d6dea0a78f23"
}
variable "ssl_policy" {
  default = "ELBSecurityPolicy-TLS-1-2-Ext-2018-06"
}
