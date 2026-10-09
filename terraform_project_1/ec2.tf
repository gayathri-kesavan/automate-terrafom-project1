resource "aws_instance" "tf_project1_ec2" {
  count=2
  ami           = "ami-06259b63260eddc13"
  instance_type = "t3.micro"
  subnet_id     = [aws_subnet.tf_project1_pub_sub1.id,aws_subnet.tf_project1_pub_sub2.id][count.index]
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  associate_public_ip_address = true 

  user_data = <<-EOF
    #!/bin/bash
    apt-get update -y
    apt-get install -y docker.io
    systemctl enable --now docker
  EOF
  
  tags = {
    Name = "tf_project1_ec2-${count.index + 1}"
  }
}
resource "aws_security_group" "allow_tls" {
  name        = "tf_project1_sg"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.tf_project1_vpc.id

  tags = {
    Name = "tf_project1y_sg"
  }
}
resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}
resource "aws_vpc_security_group_ingress_rule" "allow_https" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}
resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}