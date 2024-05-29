# Create a Launch Template Resource for the Auto-Scaling Group instances.
resource "aws_launch_template" "lt_app" {
  name        = "Python-App-LT"
  description = "Python App Launch Template"

  image_id      = lookup(var.AMIs, var.region) # ami id in specific region
  instance_type = lookup(var.instance_type, var.env)
  key_name      = var.key_pair # key-pair name to be used to connect to the instances

  block_device_mappings {
    device_name = "/dev/sda1"
    ebs {
      volume_size           = 8     # Size of the EBS volume in GB
      volume_type           = "gp2" # Type of EBS volume (General Purpose SSD in this case)
      delete_on_termination = true
    }
  }

  network_interfaces {
    associate_public_ip_address = false # Associate a public IP address to the instance
    security_groups             = [aws_security_group.sg_lt.id]
  }

  user_data = base64encode(<<EOF
#!/bin/bash
# Update the package index
apt-get update -y

# Install Python3 if not already installed
apt-get install -y python3

# Create a directory for the website
mkdir -p /var/www/html

# Create the index.html file with the HTML content
cat <<EOT > /home/ubuntu/index.html
<!DOCTYPE html>
<html>
<head>
    <title>Test Website</title>
</head>
<body>
    <h1>Hello, World!</h1>
    <p>Welcome to my test website hosted on EC2 instance using ASG.</p>
    <p>This project is using the Production Network Setup demonstrated by Abhishek Veermalla.</p>
    <br>
    <h2>Thank You!</h2>
</body>
</html>
EOT

cp /home/ubuntu/index.html /var/www/html/

# Change to the directory where index.html is located
cd /var/www/html

# Run the Python HTTP server on port 8000
nohup python3 -m http.server 8000 &
EOF
  )

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "asg-ec2"
    }
  }
}
