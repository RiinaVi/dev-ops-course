output "instance_id" {
  value = aws_instance.monitoring.id
}

output "ec2_global_ips" {
  value = aws_instance.monitoring.*.public_ip
}
