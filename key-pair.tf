# # Create RSA private key pair of size 4096 bits
# resource "tls_private_key" "proj_key_pair_pvt" {
#   algorithm = "RSA"
#   rsa_bits  = 2048
# }

# # Create local file for Private key created above 
# resource "local_sensitive_file" "proj_key_pair_pvt_local" {
#   content         = tls_private_key.proj_key_pair_pvt.private_key_pem
#   filename        = "Proj-Pvt-Key.pem"
#   file_permission = 400
# }

# # Create AWS key pair using above Private Key pair
# resource "aws_key_pair" "proj_key_pair_pub" {
#   key_name   = "Proj-Pub-Key"
#   public_key = tls_private_key.proj_key_pair_pvt.public_key_openssh
# }
