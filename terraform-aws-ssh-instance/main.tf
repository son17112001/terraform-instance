provider "aws" {
  region     = "us-east-1"
  access_key = var.aws_access
  secret_key = var.aws_secret
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.vpc_name
  cidr = var.vpc_cidr

  azs             = var.vpc_azs
  private_subnets = var.vpc_private_subnets
  public_subnets  = var.vpc_public_subnets
  enable_nat_gateway = var.vpc_enable_nat_gateway
  enable_vpn_gateway = true
  tags = var.vpc_tags
}

module "sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  name        = "ssh-access-sg"
  description = "Security group with SSH access"
  vpc_id      = module.vpc.vpc_id

  # Định nghĩa các quy tắc cho phép SSH
  ingress_cidr_blocks = ["0.0.0.0/0"]  # Thay đổi này để cải thiện bảo mật
  ingress_rules       = ["ssh-tcp"]
}


module "ec2_instances" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = var.instance_name

  ami                    = var.ami_id
  instance_type          = "t2.micro"
  key_name               = "aws_key"
  associate_public_ip_address = true
  vpc_security_group_ids = [module.sg.security_group_id]
  subnet_id              = module.vpc.public_subnets[0]
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

module "key_pair" {
  source = "terraform-aws-modules/key-pair/aws"

  key_name   = "aws_key"
  public_key = var.public_key
}