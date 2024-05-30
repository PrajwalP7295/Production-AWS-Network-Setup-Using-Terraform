# AWS Production Grade Network Project

In this project, I have created a production grade highly available AWS network consisting of :
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

> * The [network.tf](https://github.com/PrajwalP7295/Production-AWS-Network-Setup-Using-Terraform/blob/main/network.tf) file contains the code to create VPC, IGW, Subnets, EIPs, NAT, RT.