terraform {
  backend "s3" {
    bucket         = "rd-state-bucket-arina"
    dynamodb_table = "state-lock"
    key            = "terraform.tfstate"
    encrypt        = true
    region         = "us-east-2"
  }
}

provider "aws" {
  region = "us-east-2"
}

module "network" {
  source          = "./modules/network"
  vpc_name        = "RD-VPC"
  vpc_cidr        = "10.0.0.0/16"
  av_zone         = ["us-east-2a", "us-east-2b"]
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets = ["10.0.3.0/24", "10.0.4.0/24"]
}

module "security" {
  source      = "./modules/security"
  name_sg     = "public-sg"
  cidr_blocks = "0.0.0.0/0"
  from_port   = 22
  to_port     = 22
  vpc_id      = module.network.vpc_id
}

module "jenkins" {
  source               = "./modules/server"
  ami                  = "ami-0866a04d72a1f5479"
  instance_type        = "t2.micro"
  subnet_id            = module.network.public_subnets_ids[0]
  security_groups_name = module.security.sg_id
  instance_name        = "jenkins-instance"
  instance_env         = "jenkins"
  instance_role        = "core"
}

module "monitoring" {
  source = "./modules/monitoring"
  ami    = "ami-0866a04d72a1f5479"
  instance_type        = "t2.micro"
  subnet_id            = module.network.public_subnets_ids[0]
  security_groups_name = module.security.sg_id
  instance_name        = "jenkins-instance"
  instance_env         = "jenkins"
  instance_role        = "core"
}
