resource "aws_instance" "ec2" {
  ami = var.ami
  instance_type = var.instance_type
  subnet_id = var.subnet_id
  security_groups = [var.security_groups_name]
  tags = {
    Name = var.instance_name
    Role = var.instance_role
    Env = var.instance_env
  }
}
