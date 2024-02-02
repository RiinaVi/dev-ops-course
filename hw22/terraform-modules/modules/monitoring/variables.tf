variable "ami" {
  description = "AMI"
  type = string
}
variable "instance_type" {
  description = "Instance type"
  type = string
}
variable "subnet_id" {
  description = "Subnet ID"
  type = string
}
variable "security_groups_name" {
  description = "Security Groups Name"
  type = string
}
variable "instance_name" {
  description = "Instance Name"
  type = string
}
variable "instance_role" {
  description = "Instance Role"
  type = string
}
variable "instance_env" {
  description = "Instance Env"
  type = string
}
