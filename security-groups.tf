# Create Security Group for SSH into bastion EC2
resource "aws_security_group" "sg_bastion" {
  name        = "Bastion-SSH"
  description = "Allow TLS (SSH) inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.prod-network-vpc.id

  tags = {
    Name = "Bastion-SSH-SG"
  }
}

# Create Ingress(inbound) rule for SSH into bastion host - IPv4,6
resource "aws_vpc_security_group_ingress_rule" "ssh_bastion_ipv4" {
  security_group_id = aws_security_group.sg_bastion.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

# Create Egress(outbound) rule for bastion host - IPv4,6
resource "aws_vpc_security_group_egress_rule" "all_traffic_bastion_ipv4" {
  security_group_id = aws_security_group.sg_bastion.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

# Create Security Group for Launch Template - 22,80,8000

resource "aws_security_group" "sg_lt" {
  name        = "LT-SG"
  description = "Allow SSH and 8000 inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.prod-network-vpc.id

  tags = {
    Name = "Launch-Template-SG"
  }
}

# Create Ingress(inbound) rule for SSH - 22

resource "aws_vpc_security_group_ingress_rule" "ssh_app_ipv4" {
  security_group_id = aws_security_group.sg_lt.id
  cidr_ipv4         = aws_vpc.prod-network-vpc.cidr_block
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

# Create Ingress(inbound) rule for HTTP - 80

resource "aws_vpc_security_group_ingress_rule" "http_app_ipv4" {
  security_group_id = aws_security_group.sg_lt.id
  cidr_ipv4         = aws_vpc.prod-network-vpc.cidr_block
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

# Create Ingress(inbound) rule for TCP - 8000

resource "aws_vpc_security_group_ingress_rule" "app_ipv4" {
  security_group_id = aws_security_group.sg_lt.id
  cidr_ipv4         = aws_vpc.prod-network-vpc.cidr_block
  from_port         = 8000
  ip_protocol       = "tcp"
  to_port           = 8000
}

# Create Egress(outbound) rule for all traffic
resource "aws_vpc_security_group_egress_rule" "all_traffic_app_ipv4" {
  security_group_id = aws_security_group.sg_lt.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

