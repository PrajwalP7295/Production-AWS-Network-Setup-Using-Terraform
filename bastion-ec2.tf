# Create a Bastion EC2 host or Jump Server 

resource "aws_instance" "bastion" {
  ami                         = lookup(var.AMIs, var.region)
  associate_public_ip_address = "true"
  instance_type               = lookup(var.instance_type, var.env)
  subnet_id                   = aws_subnet.prod-pub-sub-1.id
  key_name                    = var.key_pair        // aws_key_pair.proj_key_pair_pub.key_name --> to create a new key pair and use it
  vpc_security_group_ids      = [aws_security_group.sg_bastion.id]

  tags = {
    Name = "Bastion-Host"
  }
}
