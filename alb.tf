# Create an Application Load Balancer to forward traffic from the internet to the Auto-Scaling Group Instances.

resource "aws_lb" "app_alb" {
  name = "Python-App-ALB"
  internal = false
  load_balancer_type = "application"
  security_groups = [ aws_security_group.sg_alb.id ]
  subnets = [ aws_subnet.prod-pub-sub-1.id, aws_subnet.prod-pub-sub-2.id ]
  enable_deletion_protection = false
  
  tags = {
    Environment = "dev"
  }
}

# Create default listener rule for the incoming traffic on ALB.

resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.app_alb.arn
  port = 80
  protocol = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.tg_app.arn
  }
}