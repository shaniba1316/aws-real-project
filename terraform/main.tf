resource "aws_vpc" "dev" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name        = "dev-vpc"
    Environment = "dev"
  }
}
resource "aws_subnet" "public_1" {
  vpc_id                  = aws_vpc.dev.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true

  tags = {
    Name        = "dev-public-subnet-1"
    Environment = "dev"
    Tier        = "public"
  }
}
resource "aws_subnet" "public_2" {
  vpc_id                  = aws_vpc.dev.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "ap-south-1b"
  map_public_ip_on_launch = true

  tags = {
    Name        = "dev-public-subnet-2"
    Environment = "dev"
    Tier        = "public"
  }
}
resource "aws_subnet" "private_1" {
  vpc_id            = aws_vpc.dev.id
  cidr_block        = "10.0.11.0/24"
  availability_zone = "ap-south-1a"

  tags = {
    Name        = "dev-private-subnet-1"
    Environment = "dev"
    Tier        = "private"
  }
}
resource "aws_subnet" "private_2" {
  vpc_id            = aws_vpc.dev.id
  cidr_block        = "10.0.12.0/24"
  availability_zone = "ap-south-1b"

  tags = {
    Name        = "dev-private-subnet-2"
    Environment = "dev"
    Tier        = "private"
  }
}

resource "aws_internet_gateway" "dev" {
  vpc_id = aws_vpc.dev.id

  tags = {
    Name        = "dev-internet-gateway"
    Environment = "dev"
  }
}
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.dev.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.dev.id
  }

  tags = {
    Name        = "dev-public-route-table"
    Environment = "dev"
  }
}
resource "aws_route_table_association" "public_1" {
  subnet_id      = aws_subnet.public_1.id
  route_table_id = aws_route_table.public.id
}
resource "aws_route_table_association" "public_2" {
  subnet_id      = aws_subnet.public_2.id
  route_table_id = aws_route_table.public.id
}
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.dev.id

  tags = {
    Name        = "dev-private-route-table"
    Environment = "dev"
  }
}
resource "aws_route_table_association" "private_1" {
  subnet_id      = aws_subnet.private_1.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_2" {
  subnet_id      = aws_subnet.private_2.id
  route_table_id = aws_route_table.private.id
}
