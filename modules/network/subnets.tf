resource "aws_subnet" "public_subnet" {
  count             = var.public_subnets["subnet_count"][0]
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.public_subnets["subnet_cidrs"][count.index]
  availability_zone = var.public_subnets["subnet_azs"][count.index]
  
  tags = {
    Name = "Public_Subnet-${count.index + 1}"
  }
}
resource "aws_subnet" "private_subnet" {
  count             = var.private_subnets["subnet_count"][0]
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.private_subnets["subnet_cidrs"][count.index]
  availability_zone = var.private_subnets["subnet_azs"][count.index]
  
  tags = {
    Name = "Private_Subnet-${count.index + 1}"
  }
}