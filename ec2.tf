data "aws_subnets" "public1" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
  tags = {
    Name = "public-subnet1"
  }
}

resource "aws_security_group" "instance-sg" {
  name   = "web-instance-sg"
  vpc_id = var.vpc_id

  # HTTP access from VPC
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Terraform   = "true"
    Environment = "dev"
    security-group = "public-subnet1"
  }
}

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "mahen-tf-instance"

  instance_type                 = "t2.micro"
  monitoring                    = true
  availability_zone             = "us-east-1a"
  for_each                      = toset(data.aws_subnets.public1.ids)
  subnet_id                     = each.value
  key_name                      = "nmahendran-kp"
  associate_public_ip_address   = true
  vpc_security_group_ids = [aws_security_group.instance-sg.id]
  tags = {
    Terraform   = "true"
    Environment = "dev"
    Subnet = "public-subnet1"
  }
  user_data = <<EOF
#! /bin/bash
sudo amazon-linux-extras install -y nginx1
sudo service nginx start
sudo rm /usr/share/nginx/html/index.html
echo '<html><head><title>Taco Team Server 2</title></head><body style=\"background-color:#1F778D\"><p style=\"text-align: center;\"><span style=\"color:#FFFFFF;\"><span style=\"font-size:28px;\">You did it! Have a &#127790;</span></span></p></body></html>' | sudo tee /usr/share/nginx/html/index.html
EOF
depends_on = [
    aws_security_group.instance-sg
  ]
}

