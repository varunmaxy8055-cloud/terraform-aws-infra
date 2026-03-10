resource "aws_vpc" "main_vpc" {

  cidr_block = var.vpc_cidr

  tags = {
    Name = "terraform-vpc"
  }

}

resource "aws_internet_gateway" "igw" {

  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "terraform-igw"
  }

}

resource "aws_subnet" "public_subnet_1" {

  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = var.public_subnet_1
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-1"
  }

}

resource "aws_subnet" "public_subnet_2" {

  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = var.public_subnet_2
  availability_zone       = "ap-south-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-2"
  }

}

resource "aws_subnet" "private_subnet_1" {

  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = var.private_subnet_1
  availability_zone = "ap-south-1a"

  tags = {
    Name = "private-subnet-1"
  }

}

resource "aws_subnet" "private_subnet_2" {

  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = var.private_subnet_2
  availability_zone = "ap-south-1b"

  tags = {
    Name = "private-subnet-2"
  }

}

resource "aws_eip" "nat_eip" {
  domain = "vpc"

  tags = {
    Name = "terraform-nat-eip"
  }
}

resource "aws_nat_gateway" "nat_gateway" {

  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet_1.id

  tags = {
    Name = "terraform-nat-gateway"
  }

}

resource "aws_route_table" "public_route_table" {

  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-route-table"
  }

}

resource "aws_route_table_association" "public_subnet_1_association" {

  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_route_table.id

}

resource "aws_route_table_association" "public_subnet_2_association" {

  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public_route_table.id

}

resource "aws_route_table" "private_route_table" {

  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }

  tags = {
    Name = "private-route-table"
  }

}

resource "aws_route_table_association" "private_subnet_1_association" {

  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.private_route_table.id

}

resource "aws_route_table_association" "private_subnet_2_association" {

  subnet_id      = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.private_route_table.id

}

resource "aws_instance" "app_server" {

  ami           = "ami-0f58b397bc5c1f2e8"
  instance_type = var.instance_type

  subnet_id = aws_subnet.private_subnet_1.id

  tags = {
    Name = "terraform-ec2"
  }

}

resource "aws_s3_bucket" "private_bucket" {

  bucket = "varun-terraform-private-bucket-2026"

  tags = {
    Name = "terraform-private-bucket"
  }

}