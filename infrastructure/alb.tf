resource "aws_lb" "fastapi_alb" {
  name               = "fastapi-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.fastapi_sg.id]
  subnets            = aws_subnet.fastapi_public_subnet[*].id

  enable_deletion_protection = false
  idle_timeout               = 400
}

resource "aws_lb_target_group" "fastapi_tg" {
  name        = "fastapi-tg"
  port        = 8000
  protocol    = "HTTP"
  vpc_id      = aws_vpc.fastapi_vpc.id
  target_type = "ip"

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.fastapi_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.fastapi_tg.arn
  }
}

output "alb_dns_name" {
  value       = aws_lb.fastapi_alb.dns_name
  description = "The DNS name of the load balancer"
}
