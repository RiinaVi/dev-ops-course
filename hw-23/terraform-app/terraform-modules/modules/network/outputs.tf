output "vpc_id" {
  value = aws_vpc.app_vpc.id
}

output "public_subnets_ids" {
  value = [ for subnet in aws_subnet.app_public_subnet : subnet.id ]
}

output "private_subnet_ids" {
  value = [ for subnet in aws_subnet.app_private_subnet : subnet.id ]
}

output "nat_gw_id" {
  value = aws_nat_gateway.app_natgw.id
}

output "igw_id" {
  value = aws_internet_gateway.app_igw.id
}
