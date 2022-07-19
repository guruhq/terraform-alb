locals {
  tg = var.target_group_name_override != null ? var.target_group_name_override : "${var.project}-${var.environment}-tg"

}
resource "aws_lb" "main" {
  security_groups    = var.lb_security_groups
  subnets            = var.public_subnet_ids
  name               = "${var.project}-${var.environment}"
  internal           = var.lb_internal_bool
  load_balancer_type = "application"

  access_logs {
    bucket  = var.access_logs_bucket
    prefix  = "${var.project}-${var.environment}"
    enabled = var.access_logs_enabled
  }

  tags = {
    Name        = "${var.project}-${var.environment}"
    Project     = var.project
    Environment = var.environment
  }
}

resource "aws_lb_target_group" "main" {
  name = local.tg

  port        = var.port
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = var.target_type

  deregistration_delay = var.deregistration_delay
  slow_start           = var.slow_start

  health_check {
    healthy_threshold   = var.healthy_threshold
    interval            = var.interval
    protocol            = "HTTP"
    timeout             = var.timeout
    path                = var.health_check_path
    unhealthy_threshold = var.unhealthy_threshold
    matcher             = var.hc_matchers
  }
  tags = {
    Name        = local.tg
    Project     = var.project
    Environment = var.environment
  }
  depends_on = [
    "aws_lb.main"
  ]
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.main.id
  port              = var.lb_port
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.main.id
    type             = "forward"
  }

  lifecycle {
    ignore_changes = [default_action[0]]
  }
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.main.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = var.ssl_policy
  certificate_arn   = var.certificate_arn

  default_action {
    target_group_arn = aws_lb_target_group.main.arn
    type             = "forward"
  }

  lifecycle {
    ignore_changes = [default_action[0]]
  }
}
