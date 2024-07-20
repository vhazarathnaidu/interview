resource "aws_vpc" "vpc-cidr" {

  cidr_block = var.vpc_cidr


  tags = {
    "Name" = "vpc-oportun-fin-ntier"
    "Env"  = "dev"
  }
}

resource "aws_subnet" "subnets" {
  count      = length(var.public_subnets)
  vpc_id     = aws_vpc.vpc-cidr.id
  cidr_block = var.public_subnets[count.index]
  availability_zone = var.azs[count.index]
  map_public_ip_on_launch = true
  enable_resource_name_dns_aaaa_record_on_launch = true
  tags = {
    Name = "subnet ${count.index}"
  }
}


