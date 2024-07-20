terraform {
  backend "s3" {

    #s3 bucket name oportun-tfstate
    bucket = "oportun-tfstate"

    #here key is where we need to store
    key = "eks-tf-state/terraform.tfstate"

    # In which region bucket is availeble , in our example US East (N.Virginia)
    region = "us-east-1"
  }
}