# Instance Target Group for ALB 

resource "aws_lb_target_group" "tg_app" { 
 name     = "Python-App-TG"
 port     = 8000
 protocol = "HTTP"
 vpc_id   = aws_vpc.prod-network-vpc.id
}
