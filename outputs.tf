# Network outputs 

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

output "bastion_pub_ip" {
  value = aws_instance.bastion.public_ip
}

# output "lt_id" {
  
# }

# output "lt_name" {
  
# }

# output "asg_id" {
  
# }

# output "asg_name" {
  
# }

# output "tg_id" {
  
# }

# output "tg_name" {
  
# }