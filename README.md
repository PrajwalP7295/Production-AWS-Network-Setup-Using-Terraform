# AWS Production Grade Network Project

In this project, I have created a production grade highly available AWS network consisting of:
- 1 VPC (Virtual Private Cloud)
- 1 IGW (Internet Gateway)
- 4 Subnets 
    - 2 Public
    - 2 Private
- 2 Elastic IPs (EIPs) - for both NAT Gateways 
- 2 NAT (Network Address Translation) Gateways - 1 in each Public Subnet
- 3 Route Tables (RT)
    - Public Subnets' traffic to Internet Gateway
    - Private Subnet 1 traffic to NAT Gateway 1
    - Private Subnet 2 traffic to NAT Gateway 2 
- 1 [Bastion EC2 Host](https://github.com/PrajwalP7295/Production-AWS-Network-Setup-Using-Terraform/blob/main/bastion-ec2.tf)
- 3 [Security Groups](https://github.com/PrajwalP7295/Production-AWS-Network-Setup-Using-Terraform/blob/main/security-groups.tf) (SG)
    - Allowing SSH traffic from anywhere to Bastion Host
    - Allowing traffic from Bastion Host (22), Application Load Balancer (ALB) (80, 8000) to the instances in Auto-Scaling Group 
    - Allowing all traffic on port 80 from internet to the ALB
- 1 [Launch Template](https://github.com/PrajwalP7295/Production-AWS-Network-Setup-Using-Terraform/blob/main/launch_template.tf) (LT)
- 1 [Auto-Scaling Group](https://github.com/PrajwalP7295/Production-AWS-Network-Setup-Using-Terraform/blob/main/asg.tf) (ASG)
    - 2 Instances (Min.)
- 1 [Target Group](https://github.com/PrajwalP7295/Production-AWS-Network-Setup-Using-Terraform/blob/main/target-group.tf) (TG)
- 1 [Application Load Balancer](https://github.com/PrajwalP7295/Production-AWS-Network-Setup-Using-Terraform/blob/main/alb.tf) (ALB)

> The [network.tf](https://github.com/PrajwalP7295/Production-AWS-Network-Setup-Using-Terraform/blob/main/network.tf) file contains the code to create VPC, IGW, Subnets, EIPs, NAT, RT.

## Summary of the Infrastructure

- After deploying the network infrastructure in AWS, I created a Bastion Host in one of the public subnets to connect to the instances running my project web server.
- Created a launch template which is used by auto-scaling groups to provision or destroy instances (scale in or scale out) based on the resource usage specified.
- In this launch template, I made use of __"User Data"__ to set up the instances during boot. It is as follows:
```
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

# Run the Python HTTP server on port 8000 as a background process
nohup python3 -m http.server 8000 &
```
- After this, I created an auto-scaling group that makes use of the above launch template and mentioned the desired (2), minimum (1) and maximum (3) instance capacity.
- Then, created a target group which will register the auto-scaling group instances as the targets for the application load balancer traffic.
- Created an application load balancer in public subnets with a default action listener rule to forward traffic received on port 80 to the target group attached to it. 
- Finally, I created security groups for bastion host, auto-scaling group instances, application load balancer to secure them and only allow specific traffic. 
