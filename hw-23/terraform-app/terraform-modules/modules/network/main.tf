resource "aws_vpc" "app_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "app_public_subnet" {
  for_each = { for idx, cidr in var.public_subnets : idx => cidr}
  vpc_id = aws_vpc.app_vpc.id
  cidr_block = each.value
  availability_zone = var.av_zone[each.key]
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.vpc_name}-public-${each.key}"
  }
}

resource "aws_subnet" "app_private_subnet" {
  for_each = { for idx, cidr in var.private_subnets : idx => cidr}
  vpc_id = aws_vpc.app_vpc.id
  cidr_block = each.value
  availability_zone = var.av_zone[each.key]
  tags = {
    Name = "${var.vpc_name}-private-${each.key}"
  }
}

resource "aws_internet_gateway" "app_igw" {
  vpc_id = aws_vpc.app_vpc.id
  tags = {
    Name = "${var.vpc_name}-gw"
  }
}

resource "aws_eip" "nat" {
  domain = "vpc"
}

resource "aws_nat_gateway" "app_natgw" {
  subnet_id = values(aws_subnet.app_public_subnet)[0].id
  allocation_id = aws_eip.nat.id
  tags = {
    Name = "${var.vpc_name}-nat"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.app_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.app_igw.id
  }
  tags = {
    Name = "${var.vpc_name}-rt-public"
  }
}

resource "aws_route_table_association" "app_rt_public" {
  for_each = aws_subnet.app_public_subnet
  route_table_id = aws_route_table.public.id
  subnet_id = each.value.id
}

resource "aws_route_table" "app_rt_private" {
  vpc_id = aws_vpc.app_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.app_natgw.id
  }
  tags = {
    Name = "${var.vpc_name}-rt-private"
  }
}

resource "aws_route_table_association" "private" {
  for_each = aws_subnet.app_private_subnet
  route_table_id = aws_route_table.app_rt_private.id
  subnet_id = each.value.id
}
