variable "name_sg" {
  description = "Name of the security group"
  type = string
}

variable "vpc_id" {
  description = "Id of the VPC"
  type = string
}

variable "cidr_blocks" {
  description = "The CIDR blocks for inbound traffic"
  type = string
}

variable "ingress_ports" {
  description = "List of ingress ports"
  type = list(number)
}
