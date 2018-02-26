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
  name = "${var.project}-${var.environment}-target-group"

  port     = "${var.port}"
  protocol = "HTTP"
  vpc_id   = "${var.vpc_id}"

  health_check {
    healthy_threshold   = "3"
    interval            = "30"
    protocol            = "HTTP"
    timeout             = "3"
    path                = "${var.health_check_path}"
    unhealthy_threshold = "2"
    matcher             = "200,404"
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
