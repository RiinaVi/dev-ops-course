resource "aws_instance" "app_server" {
  ami = var.ami
  instance_type = var.instance_type
  subnet_id = var.subnet_id
  security_groups = [var.security_groups_name]
  key_name = "terraform_app_ec2_key"
  associate_public_ip_address = true
  tags = {
    Name = var.instance_name
    Role = var.instance_role
    Env = var.instance_env
  }
}

resource "aws_key_pair" "terraform_app_ec2_key" {
  key_name = "terraform_app_ec2_key"
  public_key = file("terraform_app_ec2_key.pub")
}
