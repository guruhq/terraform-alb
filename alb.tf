resource "aws_lb" "main" {
  security_groups    = ["${var.lb_security_groups}"]
  subnets            = ["${var.public_subnet_ids}"]
  name               = "${var.project}-${var.environment}"
  internal           = "${var.lb_internal_bool}"
  load_balancer_type = "application"

  tags {
    Name        = "${var.project}-${var.environment}"
    Project     = "${var.project}"
    Environment = "${var.environment}"
  }
}

resource "aws_lb_target_group" "main" {
  name        = "${var.project}-${var.environment}-target-group"

  port        = "${var.port}"
  protocol    = "HTTP"
  vpc_id      = "${var.vpc_id}"
  target_type = "${var.target_type}"

  health_check {
    healthy_threshold   = "3"
    interval            = "30"
    protocol            = "HTTP"
    timeout             = "3"
    path                = "${var.health_check_path}"
    unhealthy_threshold = "2"
    matcher             = "${var.hc_matchers}"
  }
  tags {
    Name        = "${var.project}-${var.environment}-target-group"
    Project     = "${var.project}"
    Environment = "${var.environment}"
  }
  depends_on = [
    "aws_lb.main"
  ]
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = "${aws_lb.main.id}"
  port              = "${var.lb_port}"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_lb_target_group.main.id}"
    type             = "forward"
  }
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = "${aws_lb.main.arn}"
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS-1-1-2017-01"
  certificate_arn   = "arn:aws:acm:us-west-2:495243515911:certificate/a7b25b53-cf9c-4e16-8e25-d6dea0a78f23"

  default_action {
    target_group_arn = "${aws_lb_target_group.main.arn}"
    type             = "forward"
  }
}
