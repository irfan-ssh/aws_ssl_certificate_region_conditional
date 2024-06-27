
resource "aws_lb" "my_loadbalancer" {
  name               = "my-load-balancer"
  internal           = false
  load_balancer_type = "application"

  security_groups = ["sg-0cf6ca0c5400a63f3"]
  subnets         = ["subnet-028ae31fa4b268949", "subnet-0f8ec7eb70b8d464d"]

  enable_deletion_protection = false
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.my_loadbalancer.arn
  protocol          = "HTTP"
  port              = "80"

  default_action {
    type = "redirect"
    redirect {
      protocol    = "HTTPS"
      port        = "443"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.my_loadbalancer.arn
  protocol          = "HTTPS"
  port              = "443"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = local.loadbalancer_cert_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }
}

resource "aws_lb_target_group" "target_group" {
  name        = "tg-loadbalancer"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = "vpc-08583a3b75883928b"
  
  tags = {
    Name = "target group for loadbalancer"
  }
}
