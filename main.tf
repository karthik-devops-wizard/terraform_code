module "vpc" {
  source = "./modules/aws_infra/vpc"
  environment  = var.environment
  vpc_cidr = var.vpc_cidr
  public_subnets_cidr = var.public_subnets_cidr
  private_subnets_cidr = var.private_subnets_cidr
  region = var.region
  availability_zones  = var.availability_zones
}
