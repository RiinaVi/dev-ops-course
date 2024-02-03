variable "region" {
  description = "AWS Region"
  type        = string
}

variable "vpc_cidr" {
  description = "VPC CIDR Block"
  type        = string
}

variable "public_subnet_cidr" {
  description = "Public Subnet CIDR"
  type        = string
}

variable "private_subnet_cidr" {
  description = "Private Subnet CIDR"
  type        = string
}

variable "ami_id" {
  description = "AMI ID Ubuntu 22.04"
  type        = string
}

variable "instance_type" {
  description = "Instance Type"
  type        = string
}
