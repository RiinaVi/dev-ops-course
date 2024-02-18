output "instance_id" {
  value = aws_instance.app_server.id
}

output "ec2_global_ips" {
  value = aws_instance.app_server.*.public_ip
}
