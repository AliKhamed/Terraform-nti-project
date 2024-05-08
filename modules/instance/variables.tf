variable "ami" {
  type = string
}
variable "ec2" {
  type = map(list(any))
}
variable "vpc_id" {
}
variable "sg" {
  type = string
}
variable "ec2_subnet_id" {
  type = list(any)
}
variable "privte_lb_dns" {
}