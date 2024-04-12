output "vpc_id" {
  value = aws_vpc.prod-network-vpc.id
}

output "igw_id" {
  value = aws_internet_gateway.prod-network-igw.id
}

output "nat-1_id" {
  value = aws_nat_gateway.pub-nat-1.id
}

output "nat-2_ip" {
  value = aws_nat_gateway.pub-nat-2.id
}