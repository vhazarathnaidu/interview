# ec2

#Create key-pair
resource "aws_key_pair" "terraform-demo" {
  key_name   = "terraform-demo"
  public_key = file("terraform-demo.pub")
}

#Create ec2 instance
resource "aws_instance" "my-instance" {
  ami           = var.ami
  instance_type = var.instance_type
  user_data     = file("install_apache.sh")
  tags = {
    Name  = "Terraform-${count.index + 1}"
    Batch = "5AM"
  }
}

# Create multiple ec2 instances Using count
resource "aws_instance" "my-instance" {
  count         = var.instance_count
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = aws_key_pair.terraform-demo.key_name
  user_data     = file("install_apache.sh")

  tags = {
    Name  = "Terraform-${count.index + 1}"
    Batch = "5AM"
  }
}

