# Create Security Group for 3 General Rules - 22,80,443

resource "aws_security_group" "sg_gen_3" {
  name        = "Gen-3"
  description = "Allow TLS (SSH,HTTP/s) inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.prod-network-vpc.id

  tags = {
    Name = "Allow-SSH-HTTP/s"
  }
}

# Create Ingress(inbound) rules for SSH - 22

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_ipv4" {
  security_group_id = aws_security_group.sg_gen_3.id
  cidr_ipv4         = aws_vpc.prod-network-vpc.cidr_block
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

# Create Ingress(inbound) rules for HTTP - 80

resource "aws_vpc_security_group_ingress_rule" "allow_http_ipv4" {
  security_group_id = aws_security_group.sg_gen_3.id
  cidr_ipv4         = aws_vpc.prod-network-vpc.cidr_block
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

# Create Ingress(inbound) rules for HTTPS - 443

resource "aws_vpc_security_group_ingress_rule" "allow_https_ipv4" {
  security_group_id = aws_security_group.sg_gen_3.id
  cidr_ipv4         = aws_vpc.prod-network-vpc.cidr_block
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

# Create Egress(outbound) rules for all traffic
resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.sg_gen_3.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

