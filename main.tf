module "network" {
  source                 = "./modules/network"
  vpc_cidr               = var.vpc_cidr
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  vpc_name               = var.vpc_name
}
module "security-group" {
  source = "./modules/security-group"
  sg = var.sg
  sg_name = "sg"
  vpc_id = module.network.vpc_id
}

module "instance" {
  source = "./modules/instance"
  ec2 = var.ec2
  ami = var.ami
  vpc_id = module.network.vpc_id
  sg = module.security-group.sg_id
  ec2_subnet_id = [
                  module.network.public_subnet_ids[0] ,
                  module.network.public_subnet_ids[1] ,
                  module.network.private_subnet_ids[0] ,
                  module.network.private_subnet_ids[1]
                  ]
  privte_lb_dns = module.load-balancer.ALB_DNS[1]
}
module "load-balancer" {
  source = "./modules/load-balancer"
  lb = var.lb
  sg = module.security-group.sg_id
  vpc_id = module.network.vpc_id
  lb_subnets = [ module.network.public_subnet_ids , module.network.private_subnet_ids]
  target_group_instances_id_pub = module.instance.public_ec2_ids
  target_group_instances_id_pri = module.instance.private_ec2_ids
}

# data "aws_instances" "instances_data" {
#   filter {
#     name = "tag:ENV"
#     values = ["Public_project2"]
#   }
# }
resource "local_file" "public_ips" {
    content  = " \n DNS_lb : ${module.load-balancer.ALB_DNS[0]} \n publicIP 1: ${module.instance.public_ec2_ips[0]}  \n publicIP 2: ${module.instance.public_ec2_ips[1]} \n privateIP 1: ${module.instance.private_ec2_ips[0]} \n privateIP 2: ${module.instance.private_ec2_ips[1]}}"
    filename = "./ips.txt"
    depends_on = [ module.instance ]
}
