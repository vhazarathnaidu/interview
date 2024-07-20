variable "region" {
    type = string
  validation {
    condition = substr(var.region, 0, 3) == "us-"
    error_message = "region should be us only"
  }
}