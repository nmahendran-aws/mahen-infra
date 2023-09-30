module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "mahen-tf-instance"

  instance_type          = "t2.micro"
  monitoring             = true
  subnet_id              = data.aws_subnets.public-subnet1.id
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
