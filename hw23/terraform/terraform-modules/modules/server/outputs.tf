output "instance_id" {
  value = aws_instance.ec2.id
}

output "ec2_global_ips" {
  value = aws_instance.ec2.*.public_ip
}
