# Create Security Group for SSH into bastion EC2
resource "aws_security_group" "sg_ssh_bastion" {
  name        = "SSH"
  description = "Allow TLS (SSH) inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.prod-network-vpc.id

  tags = {
    Name = "Allow-SSH"
  }
}

# Create Ingress(inbound) rules for SSH into bastion host - IPv4,6
resource "aws_vpc_security_group_ingress_rule" "allow_ssh_bastion_ipv4" {
  security_group_id = aws_security_group.sg_ssh_bastion.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

# Create Egress(outbound) rules for bastion host - IPv4,6
resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_bastion_ipv4" {
  security_group_id = aws_security_group.sg_ssh_bastion.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

