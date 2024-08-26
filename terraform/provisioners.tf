#Example
resource "null_resource" "example" {
  provisioner "local-exec" {
    command = "echo Hello World!"
  }
}


#Example 
provider "aws" {
  region = "us-east-1"
}

data "aws_ami" "ubuntu" {
  filter {
    name   = "name"
    values = ["ubuntu-*"]
  }
  most_recent = true
}

resource "aws_key_pair" "example" {
  key_name   = "key"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "local.instance_type"
  key_name      = aws_key_pair.example.key_name
}

resource "null_resource" "copy_file_on_vm" {
  depends_on = [
    aws_instance.web
  ]
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("~/.ssh/id_rsa")
    host        = aws_instance.web.public_dns
  }
  provisioner "file" {
    source      = "./file.yaml"
    destination = "./file.yaml"
  }
}

#If we want to run the provisioner to handle some logic at creation time/destroy-time provisioners using 'when' 
resource "aws_instance" "my_vm" {
 ami           = "var.ami" //Amazon Linux AMI
 instance_type = "var.instance_type"
 
 provisioner "local-exec" {
   command = "echo 'Creation is successful.' >> creation.txt"
 }
 
 provisioner "local-exec" {
   when = destroy
   command = "echo 'Destruction is successful.' >> destruction.txt"
 }
 
}




# Local-exec example

resource "aws_instance" "my_vm" {
 ami           = "var.ami" //Amazon Linux AMI
 instance_type = "var.instance_type"
 
 provisioner "local-exec" {
   command = "echo ${self.private_ip} >> private_ip.txt"
 }
 
 tags = {
   Name = "var.name_tag",
 }
}