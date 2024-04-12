# Create a VPC
resource "aws_vpc" "prod-network-vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  tags = {
    Name = "Prod-network-vpc"
  }
}

# Create 2 Public Subnets 
resource "aws_subnet" "prod-pub-sub-1" {
  vpc_id                  = aws_vpc.prod-network-vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "Prod-pub-sub-1"
  }
}

resource "aws_subnet" "prod-pub-sub-2" {
  vpc_id                  = aws_vpc.prod-network-vpc.id
  cidr_block              = "10.0.16.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "Prod-pub-sub-2"
  }
}

# Create 2 Private Subnets
resource "aws_subnet" "prod-pvt-sub-1" {
  vpc_id            = aws_vpc.prod-network-vpc.id
  cidr_block        = "10.0.128.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "Prod-pvt-sub-1"
  }
}

resource "aws_subnet" "prod-pvt-sub-2" {
  vpc_id            = aws_vpc.prod-network-vpc.id
  cidr_block        = "10.0.144.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "Prod-pvt-sub-2"
  }
}

# Create an Internet Gateway
resource "aws_internet_gateway" "prod-network-igw" {
  vpc_id = aws_vpc.prod-network-vpc.id

  tags = {
    Name = "Prod-network-igw"
  }
}

# Create a Route Table for the Internet Gateway
resource "aws_route_table" "rtb-igw" {
  vpc_id = aws_vpc.prod-network-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.prod-network-igw.id
  }

  tags = {
    Name = "Rtb-igw"
  }
}

# Associate the above IGW Route Table to Public Subnets
resource "aws_route_table_association" "rtba-igw-1" {
  subnet_id      = aws_subnet.prod-pub-sub-1.id
  route_table_id = aws_route_table.rtb-igw.id
}

resource "aws_route_table_association" "rtba-igw-2" {
  subnet_id      = aws_subnet.prod-pub-sub-2.id
  route_table_id = aws_route_table.rtb-igw.id
}


# Create 2 Elastic IPs (EIP) for NAT Gateways
resource "aws_eip" "nat-eip-1" {
  domain = "vpc"

  tags = {
    Name = "Nat-Eip-1"
  }
}

resource "aws_eip" "nat-eip-2" {
  domain = "vpc"

  tags = {
    Name = "Nat-Eip-2"
  }
}

# Create 2 NAT Gateways
resource "aws_nat_gateway" "pub-nat-1" {
  allocation_id = aws_eip.nat-eip-1.id
  subnet_id     = aws_subnet.prod-pub-sub-1.id
  depends_on    = [aws_internet_gateway.prod-network-igw]

  tags = {
    Name = "Pub-NAT-1"
  }
}

resource "aws_nat_gateway" "pub-nat-2" {
  allocation_id = aws_eip.nat-eip-2.id
  subnet_id     = aws_subnet.prod-pub-sub-2.id
  depends_on    = [aws_internet_gateway.prod-network-igw]

  tags = {
    Name = "Pub-NAT-2"
  }
}

# Create a Route Table for Private Subnet 1 to NAT Gateway-1
resource "aws_route_table" "rtb-nat-1" {
  vpc_id = aws_vpc.prod-network-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.pub-nat-1.id
  }

  tags = {
    Name = "Rtb-Nat-1"
  }
}

resource "aws_route_table" "rtb-nat-2" {
  vpc_id = aws_vpc.prod-network-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.pub-nat-2.id
  }

  tags = {
    Name = "Rtb-Nat-2"
  }
}

# Associate the above NAT Route Tables to Private Subnets
resource "aws_route_table_association" "rtba-nat-1" {
  subnet_id      = aws_subnet.prod-pvt-sub-1.id
  route_table_id = aws_route_table.rtb-nat-1.id
}

resource "aws_route_table_association" "rtba-nat-2" {
  subnet_id      = aws_subnet.prod-pvt-sub-2.id
  route_table_id = aws_route_table.rtb-nat-2.id
}
