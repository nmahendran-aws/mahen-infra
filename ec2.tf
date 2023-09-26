module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "mahen-tf-instance"

  instance_type          = "t2.micro"
  key_name               = "user1"
  monitoring             = true
  subnet_id              = element(module.vpc.public_subnets, 0)
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}