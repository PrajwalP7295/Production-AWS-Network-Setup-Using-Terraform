# Network - VPC_id, IGW_id, NAT-1 and NAT-2 public IPs 

output "vpc_id" {
  value = aws_vpc.prod-network-vpc.id
}

output "igw_id" {
  value = aws_internet_gateway.prod-network-igw.id
}

output "nat-1_pub_ip" {
  value = aws_nat_gateway.pub-nat-1.public_ip
}

output "nat-2_pub_ip" {
  value = aws_nat_gateway.pub-nat-2.public_ip
}

# Bastioni Host's Public IP

output "bastion_pub_ip" {
  value = aws_instance.bastion.public_ip
}

# Launch Template's ID and Name

output "lt_id" {
  value = aws_launch_template.lt_app.id
}

output "lt_name" {
  value = aws_launch_template.lt_app.name
}

# Auto-Scaling Group's ID and Name

output "asg_id" {
  value = aws_autoscaling_group.asg_app.id
}

output "asg_name" {
  value = aws_autoscaling_group.asg_app.name
}

# Target Group's Name 

output "tg_name" {
  value = aws_lb_target_group.tg_app.name
}

# Application Load Balancer's Name 

output "lb_name" {
  value = aws_lb.app_alb.name
}