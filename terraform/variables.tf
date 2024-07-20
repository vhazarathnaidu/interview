

variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR"
  default     = "10.100.0.0/16"
}

variable "public_subnets" {
  type        = list(string)
  default     = ["10.100.0.0/24", "10.100.1.0/24", "10.100.2.0/24"]
  description = "public subnet CIDR"
}

variable "azs" {
    type= list(string)
    default = ["us-east-1a", "us-east-1b", "us-east-1c"]
    description = "availability zones"
}