resource "aws_vpc" "tf_project1_vpc" {
  cidr_block       = "11.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "auto_terra_pro1_vpc"
  }
}
resource "aws_subnet" "tf_project1_pub_sub1" {
  vpc_id     = aws_vpc.tf_project1_vpc.id
  cidr_block = "11.0.1.0/24"
   map_public_ip_on_launch = true

  tags = {
    Name = "auto_terra_pro1_pub1"
  }
}
resource "aws_subnet" "tf_project1_pub_sub2" {
  vpc_id     = aws_vpc.tf_project1_vpc.id
  cidr_block = "11.0.2.0/24"
   map_public_ip_on_launch = true

  tags = {
    Name = "auto_terra_pro1_pub2"
  }
}
resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.tf_project1_vpc.id

  tags = {
    Name = "auto_terra_pro1_igw"
  }
}
resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.tf_project1_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW.id
  }
tags = {    
    Name = "auto_terra_pro1_route_table"
  }
}
resource "aws_route_table_association" "route_table_association1" {
  subnet_id      = aws_subnet.tf_project1_pub_sub1.id
  route_table_id = aws_route_table.route_table.id
}
resource "aws_route_table_association" "route_table_association2" {
  subnet_id      = aws_subnet.tf_project1_pub_sub2.id
  route_table_id = aws_route_table.route_table.id
}
