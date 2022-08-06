resource "aws_lb" "my-web" {
  name               = "my-web-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.default.id]
  subnets            = aws_subnet.public_subnet.*.id
  tags = {
    env = "var.environment"
  }
}


resource "aws_lb_target_group" "my-web-tg" {
  name        = "my-web-alb-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = aws_vpc.vpc.id
}


resource "aws_lb_listener" "my-personal-web" {
  load_balancer_arn = aws_lb.my-web.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.my-web-tg.arn
  }
}