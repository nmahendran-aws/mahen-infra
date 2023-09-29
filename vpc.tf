module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "mahen-tf-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]
  private_subnet_names = ["private-subnet1","private-subnet2"]
  public_subnet_names = ["public-subnet1","public-subnet2"]

  enable_nat_gateway = false
  enable_vpn_gateway = false
  create_igw = true

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}
