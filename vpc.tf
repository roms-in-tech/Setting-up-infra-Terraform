# VPC
resource "aws_vpc" "zoeencloud" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "zoeencloud-vpc"
  }
}

# Public Subnet with Internet Gateway
resource "aws_subnet" "zoeencloud-public" {
  vpc_id            = aws_vpc.zoeencloud.id
  cidr_block        = var.subnet_cidr_block_public_1
  availability_zone = "ap-south-1a"

  tags = {
    Name = "zoeencloud-public-subnet"
  }
}

resource "aws_internet_gateway" "zoeencloud_igw" {
  vpc_id = aws_vpc.zoeencloud.id

  tags = {
    Name = "zoeencloud-igw"
  }
}

resource "aws_route_table" "zoeencloud_public_route_table" {
  vpc_id = aws_vpc.zoeencloud.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.zoeencloud_igw.id
  }
}

resource "aws_route_table_association" "zoeencloud_public_subnet_association" {
  subnet_id      = aws_subnet.zoeencloud-public.id
  route_table_id = aws_route_table.zoeencloud_public_route_table.id
}

# Private Subnets
resource "aws_subnet" "zoeencloud-private-1" {
  vpc_id            = aws_vpc.zoeencloud.id
  cidr_block        = var.subnet_cidr_block_1
  availability_zone = "ap-south-1b"

  tags = {
    Name = "zoeencloud-private-subnet-1"
  }
}

resource "aws_subnet" "zoeencloud-private-2" {
  vpc_id            = aws_vpc.zoeencloud.id
  cidr_block        = var.subnet_cidr_block_2
  availability_zone = "ap-south-1c"

  tags = {
    Name = "zoeencloud-private-subnet-2"
  }
}

# NAT Gateway
resource "aws_nat_gateway" "zoeencloud_nat_gateway" {
  allocation_id = aws_eip.zoeencloud_eip.id
  subnet_id     = aws_subnet.zoeencloud-public.id

  depends_on = [
    aws_internet_gateway.zoeencloud_igw,
  ]
}

resource "aws_eip" "zoeencloud_eip" {  
}

resource "aws_route_table" "zoeencloud_private_route_table" {
  vpc_id = aws_vpc.zoeencloud.id

  depends_on = [
    aws_nat_gateway.zoeencloud_nat_gateway,
  ]
}

resource "aws_route_table_association" "zoeencloud_private_subnet_association_1" {
  subnet_id      = aws_subnet.zoeencloud-private-1.id
  route_table_id = aws_route_table.zoeencloud_private_route_table.id
}

resource "aws_route" "zoeencloud_private_route_to_nat_gateway" {
  route_table_id         = aws_route_table.zoeencloud_private_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.zoeencloud_nat_gateway.id
}

resource "aws_db_subnet_group" "romia-subnet-group" {
  name       = "zoeencloud-subnet-group"
  subnet_ids = [aws_subnet.zoeencloud-private-1.id, aws_subnet.zoeencloud-private-2.id]
}