vpc_name     = "nti-vpc"
vpc_cidr     = "10.0.0.0/16"
region       = "us-east-1"
ami = "ami-04b70fa74e45c3917"
public_subnets = {
  subnet_count = [2]
  subnet_cidrs = ["10.0.0.0/24" , "10.0.1.0/24"]
  subnet_azs   = ["us-east-1a" , "us-east-1b"]
}
private_subnets = {
  subnet_count = [2]
  subnet_cidrs = ["10.0.2.0/24" , "10.0.3.0/24"]
  subnet_azs   = ["us-east-1a" , "us-east-1b"]
}
ec2 = {
    "instance_count" = [2,2]
    "instance_type" = ["t2.micro" , "t2.micro","t2.micro" , "t2.micro"]
    "key_name" = ["aws-key"]
    "instance_name" = ["public_ec2" , "public_ec2","private_ec2" , "private_ec2"]
}
sg = {
  ingress_count = [{count = 3}]
  ingress_rule = [{
    port = 443
    protocol = "tcp"
    cidr = "0.0.0.0/0"
  } , 
  { port = 80
    protocol = "tcp"
    cidr = "0.0.0.0/0"
  },
  { port = 22
    protocol = "tcp"
    cidr = "0.0.0.0/0"
  }]
}

lb = {
    lb_count = [2]
    lb_name = ["public" , "private"]
    internal = [false , true]
    instances_count = [4]
    
  }