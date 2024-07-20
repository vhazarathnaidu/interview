module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "my-vpc"
  cidr = var.vpc_cidr

  azs            = data.aws_availability_zones.azs.names
  public_subnets = var.public_subnets

  enable_dns_hostnames    = true
  map_public_ip_on_launch = true

  tags = {
    Name        = "jenkins-server-vpc"
    Terraform   = "true"
    Environment = "dev"
  }

  public_subnet_tags = {
    Name        = "jenkins-server-vpc-public-subnet"
    Terraform   = "true"
    Environment = "dev"
  }

  public_route_table_tags = {
    Name        = "jenkins-server-vpc-route_table"
    Terraform   = "true"
    Environment = "dev"
  }
}


#security group
module "sg" {
  source = "terraform-aws-modules/security-group/aws//modules/http-80"

  name        = "jenkins-server-sg"
  description = "Security group for jenkins-server cluster"
  vpc_id      = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 8080
      to_port     = 8080
      protocol    = "tcp"
      description = "HTTP"
      cidr_block  = "0.0.0.0/0"
    },
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "SSH"
      cidr_block  = "0.0.0.0/0"

    }
  ]

  egress_with_cidr_blocks = [
    {
      from_port  = 0
      to_port    = 0
      protocol   = "-1"
      cidr_block = "0.0.0.0/0"
    }
  ]

  tags = {
    Name = "jenkins-server-sg"
  }
}


module "ec2_instance" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name = "single-instance"

  instance_type               = var.instance_type
  key_name                    = "ajay_key_pair"
  monitoring                  = true
  vpc_security_group_ids      = [module.sg.security_group_id]
  subnet_id                   = module.vpc.public_subnets[0]
  ami                         = data.aws_ami.my-ubuntu-server-ami.id
  associate_public_ip_address = true
  availability_zone           = data.aws_availability_zones.azs.names[0]
  user_data                   = file("jenkins-install.sh")

  tags = {
    Name        = "jenkins-server-jenkins-server"
    Terraform   = "true"
    Environment = "dev"
  }
}