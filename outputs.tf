# Network outputs 

output "vpc_id" {
  value = aws_vpc.prod-network-vpc.id
}

output "igw_id" {
  value = aws_internet_gateway.prod-network-igw.id
}

# output "nat-1_id" {
#   value = aws_nat_gateway.pub-nat-1.id
# }

output "nat-1_pub_ip" {
  value = aws_nat_gateway.pub-nat-1.public_ip
}

# output "nat-2_id" {
#   value = aws_nat_gateway.pub-nat-2.id
# }

output "nat-2_pub_ip" {
  value = aws_nat_gateway.pub-nat-2.public_ip
}

output "key_pair_name" {
  value = var.key_pair            # aws_key_pair.proj_key_pair_pub.key_name
}

output "bastion_pub_ip" {
  value = aws_instance.bastion.public_ip
}