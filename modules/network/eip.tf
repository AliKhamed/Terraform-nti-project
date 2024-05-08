resource "aws_eip" "eip" {
  count = var.private_subnets["subnet_count"][0]
  domain = "vpc"
}