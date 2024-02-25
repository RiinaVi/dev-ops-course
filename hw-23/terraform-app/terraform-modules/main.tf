terraform {
  backend "s3" {
    bucket         = "rd-state-bucket-arina"
    dynamodb_table = "state-lock-1"
    key            = "terraform.tfstate"
    encrypt        = true
    region         = "us-east-2"
  }
}

data "aws_ami" "ubuntu_ami" {
  filter {
    name   = "state"
    values = ["available"]
  }
  filter {
    name   = "name"
    values = ["*ubuntu*"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
  most_recent = true
}

provider "aws" {
  region = "us-east-2"
}

module "network" {
  source          = "./modules/network"
  vpc_name        = "RD-VPC-APP"
  vpc_cidr        = "10.0.0.0/16"
  av_zone         = ["us-east-2a", "us-east-2b"]
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets = ["10.0.3.0/24", "10.0.4.0/24"]
}

module "security" {
  source      = "./modules/security"
  name_sg     = "public-app-sg"
  cidr_blocks = "0.0.0.0/0"
  ingress_ports = [22, 8080, 3000]
  vpc_id      = module.network.vpc_id
}

module "app" {
  source               = "./modules/server"
  ami                  = "ami-05fb0b8c1424f266b"
  instance_type        = "t2.micro"
  subnet_id            = module.network.public_subnets_ids[0]
  security_groups_name = module.security.sg_id
  instance_name        = "app-instance"
  instance_env         = "app"
  instance_role        = "app"
}

resource "local_file" "server_ip" {
  content  = module.app.server_ip
  filename = "server_ip.txt"
}
