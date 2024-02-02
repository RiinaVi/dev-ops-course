variable "name_sg" {
  description = "Name of the security group"
  type = string
}

variable "vpc_id" {
  description = "Id of the VPC"
  type = string
}

variable "from_port" {
  description = "The start range of the inbound port rule"
  type = number
}

variable "to_port" {
  description = "The end range of the inbound port rule"
  type = number
}

variable "cidr_blocks" {
  description = "The CIDR blocks for inbound traffic"
  type = string
}
