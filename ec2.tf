module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "mahen-tf-instance"

  instance_type          = "t2.micro"
  key_name               = "user1"
  monitoring             = true
  vpc_security_group_ids = ["sg-12345678"]
  subnet_id              = module.vpc.public_subnets.id
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}