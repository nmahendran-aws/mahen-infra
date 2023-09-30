data "aws_subnets" "public1" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
  tags = {
    Name = "public-subnet1"
  }
}

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "mahen-tf-instance"

  instance_type          = "t2.micro"
  monitoring             = true
  subnet_id              = data.aws_subnets.public1.id
  tags = {
    Terraform   = "true"
    Environment = "dev"
    Subnet = "public-subnet1"
  }
}
