variable "region" {
  type = string
}
variable "vpc_cidr" {
  type        = string
}
variable "vpc_name" {
  type        = string
}
variable "ami" {
  type = string
}
variable "private_subnets" {
  type = map(any)
}
variable "public_subnets" {
  type = map(any)
}
data "aws_instances" "name" {
}
variable "sg" {
  type = map(any)
}
variable "ec2" {
  type = map(list(any))
}
variable "lb" {
  type = map(any)
}
