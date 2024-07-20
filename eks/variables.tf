variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR"
}

variable "public_subnets" {
  type        = list(string)
  description = "public subnet CIDR"
}

variable "private_subnets" {
  type        = list(string)
  description = "public subnet CIDR"
}

variable "instance_types" {
  type        = list(string)
  description = "node instance type"
}