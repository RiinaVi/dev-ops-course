resource "aws_security_group" "sg" {
  name = var.name_sg
  description = "Allow inbound traffic"
  vpc_id = var.vpc_id
  ingress {
    from_port = var.from_port
    protocol  = "tcp"
    to_port   = var.to_port
    cidr_blocks = [var.cidr_blocks]
  }
  egress {
    from_port = 0
    protocol  = "-1"
    to_port   = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = var.name_sg
  }
}
