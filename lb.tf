resource "aws_lb" "this" {
  name               = var.site_name
  internal           = false
  load_balancer_type = "application"
  subnets            = [var.psubnet_id1c, var.psubnet_id1d]
  security_groups    = [aws_security_group.dev_sg.id]
  #subnets            = data.aws_subnet_ids.this.ids

  enable_cross_zone_load_balancing = true
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.this.arn

  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}

/*
resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.this.arn

  port              = 443
  protocol          = "HTTPS"

  #ssl_policy        = "ELBSecurityPolicy-2016-08"
  ssl_policy        = "ELBSecurityPolicy-TLS-1-2-2017-01"
  certificate_arn   = data.aws_acm_certificate.this.arn
  #certificate_arn   = aws_acm_certificate_validation.this.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}

data "aws_acm_certificate" "this" {
  domain = var.cert_domain
  types       = ["AMAZON_ISSUED"]
  most_recent = true
}
*/

resource "aws_lb_target_group" "this" {
  port     = 8111
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  load_balancing_algorithm_type = "least_outstanding_requests"

  stickiness {
    enabled = true
    type    = "lb_cookie"
  }


  health_check {
    healthy_threshold   = 2
    interval            = 30
    protocol            = "HTTP"
    unhealthy_threshold = 2
  }

  depends_on = [
    aws_lb.this
  ]

  lifecycle {
    create_before_destroy = true
  }
}


#Attach Instance
resource "aws_lb_target_group_attachment" "vm" {
  count = 1
  target_group_arn = aws_lb_target_group.this.arn
  target_id        = aws_instance.vm[count.index].id
  #target_id        = "${element(aws_instance.vm.*.id, count.index)}"
  port             = 8111
}

/*
resource "aws_lb_listener_rule" "redirect_based_on_path" {
  listener_arn = aws_lb_listener.this.arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alternative_target.arn
  }

  condition {
    path_pattern {
      values = ["/*"]
    }
  }
}
*/
