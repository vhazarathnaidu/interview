data "aws_ami" "my-ubuntu-server-ami" {

  most_recent = true
  owners      = ["self", "amazon"]

  filter {
    name   = "name"
    values = ["ubantu/images/hvm-ssd/ubuntu-jammy-22.04.amd64-server-20231207"]

  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_availability_zones" "azs" {

}