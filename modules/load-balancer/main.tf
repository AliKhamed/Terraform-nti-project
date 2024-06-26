resource "aws_lb" "load_balancer" {
  count = var.lb["lb_count"][0]
  name               = "lb-${var.lb["lb_name"][count.index]}"
  internal           = var.lb["internal"][count.index]
  load_balancer_type = "application"
  security_groups    = [var.sg]
  subnets = var.lb_subnets[count.index]
  enable_deletion_protection = false

  tags = {
    Name = "lb"
  }
}
resource "aws_lb_listener" "lb_listener" {
  count = 2
  load_balancer_arn = aws_lb.load_balancer[count.index].arn
  port              = 80
  protocol          = "HTTP"

default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group[count.index].arn
  }
}
resource "aws_lb_target_group" "target_group" {
  count = var.lb["lb_count"][0]
  name     = "targetGroup-${var.lb["lb_name"][count.index]}"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}


resource "aws_lb_target_group_attachment" "attach_instance" {
  count = 2
  target_group_arn = aws_lb_target_group.target_group[0].arn
  target_id        = var.target_group_instances_id_pub[count.index]
  port             = 80
}
resource "aws_lb_target_group_attachment" "attach_instance2" {
  count = 2
  target_group_arn = aws_lb_target_group.target_group[1].arn
  target_id        = var.target_group_instances_id_pri[count.index]
  port             = 80
}
