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
  user_data = templatefile("${path.module}/files/deploy_app.sh", {})
depends_on = [
    aws_security_group.instance-sg
  ]
}

