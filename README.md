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
- 1 Bastion EC2 Host 
- 3 Security Groups (SG)
    - Allowing SSH traffic from anywhere to Bastion Host
    - Allowing traffic from Bastion Host (22), Application Load Balancer (ALB) (80, 8000) to the instances in Auto-Scaling Group 
    - Allowing all traffic on port 80 from internet to the ALB
- 1 Launch Template (LT)
- 1 Auto-Scaling Group (ASG)
    - 2 Instances (Min.)
- 1 Target Group (TG)
- 1 Application Load Balancer (ALB)