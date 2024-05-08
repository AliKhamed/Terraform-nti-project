resource "aws_route_table" "igw-rtw" {
    vpc_id = aws_vpc.vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
    tags = {
      Name: "${var.vpc_name}-rtb-public"
    }
}
resource "aws_route_table_association" "rtb_igw_association" {
    count = var.public_subnets["subnet_count"][0]
    subnet_id = aws_subnet.public_subnet[count.index].id
    route_table_id = aws_route_table.igw-rtw.id
}



resource "aws_route_table" "ngw-rtw" {
    count = var.private_subnets["subnet_count"][0]
    vpc_id = aws_vpc.vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.ngw[count.index].id
    }
    tags = {
      Name: "${var.vpc_name}-rtb-private"
    }
}
resource "aws_route_table_association" "rtb_ngw_association" {
    count = var.private_subnets["subnet_count"][0]
    subnet_id = aws_subnet.private_subnet[count.index].id
    route_table_id = aws_route_table.ngw-rtw[count.index].id
}
