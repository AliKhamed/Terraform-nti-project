resource "aws_nat_gateway" "ngw" {
  count = var.private_subnets["subnet_count"][0]
  subnet_id = aws_subnet.public_subnet[count.index].id
  allocation_id = aws_eip.eip[count.index].id
}