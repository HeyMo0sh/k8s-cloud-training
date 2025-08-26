resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = { Name = "${var.prefix}-vpc" }
}
resource "aws_internet_gateway" "igw" { vpc_id = aws_vpc.vpc.id }
locals { azs = slice(data.aws_availability_zones.available.names, 0, 2) }
resource "aws_subnet" "public" {
  for_each                 = { for idx, cidr in var.public_subnet_cidrs : idx => cidr }
  vpc_id                   = aws_vpc.vpc.id
  cidr_block               = each.value
  availability_zone        = local.azs[tonumber(each.key)]
  map_public_ip_on_launch  = true
  tags = { Name = "${var.prefix}-public-${each.key}", "kubernetes.io/role/elb" = 1 }
}
resource "aws_subnet" "private" {
  for_each          = { for idx, cidr in var.private_subnet_cidrs : idx => cidr }
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = each.value
  availability_zone = local.azs[tonumber(each.key)]
  tags = { Name = "${var.prefix}-private-${each.key}", "kubernetes.io/role/internal-elb" = 1 }
}
resource "aws_eip" "nat" {
  for_each = aws_subnet.public
  domain   = "vpc"
}
resource "aws_nat_gateway" "nat" {
  for_each      = aws_subnet.public
  allocation_id = aws_eip.nat[each.key].id
  subnet_id     = aws_subnet.public[each.key].id
  depends_on    = [aws_internet_gateway.igw]
}
resource "aws_route_table" "public" { vpc_id = aws_vpc.vpc.id }
resource "aws_route" "public_inet" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}
resource "aws_route_table_association" "public_assoc" {
  for_each       = aws_subnet.public
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}
resource "aws_route_table" "private" { for_each = aws_nat_gateway.nat  vpc_id = aws_vpc.vpc.id }
resource "aws_route" "private_out" {
  for_each               = aws_route_table.private
  route_table_id         = each.value.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat[each.key].id
}
resource "aws_route_table_association" "private_assoc" {
  for_each       = aws_subnet.private
  subnet_id      = each.value.id
  route_table_id = aws_route_table.private[each.key].id
}
