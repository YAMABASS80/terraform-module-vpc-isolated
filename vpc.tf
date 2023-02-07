resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr_block
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "vpc"
  }
}

resource "aws_subnet" "private_subnet_1" {
  vpc_id = aws_vpc.this.id
  cidr_block = cidrsubnet(var.vpc_cidr_block, 8, 2 )
  availability_zone = data.aws_availability_zones.available.names[0]
  tags = {
    Name = "private_subnet_1"
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id = aws_vpc.this.id
  cidr_block = cidrsubnet(var.vpc_cidr_block, 8, 3 )
  availability_zone = data.aws_availability_zones.available.names[1]
  tags = {
    Name = "private_subnet_2"
  }
}

resource "aws_route_table" "private_subnet_1_route_table" {
  vpc_id = aws_vpc.this.id
  tags = {
    Name = "private_subnet_1_rt"
  }
}

resource "aws_route_table_association" "private_subnet_1_route_table_associate" {
  subnet_id = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.private_subnet_1_route_table.id
}

resource "aws_route_table" "private_subnet_2_route_table" {
  vpc_id = aws_vpc.this.id
  tags = {
    "Name" = "private_subnet_2_rt"
  }
}

resource "aws_route_table_association" "private_subnet_2_route_table_associate" {
  subnet_id = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.private_subnet_2_route_table.id
}