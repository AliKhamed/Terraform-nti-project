output "load-balancer-dns" {
  value = module.load-balancer.ALB_DNS[0]
}