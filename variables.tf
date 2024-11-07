variable "customer_role_arns" {
  type = list(string)
}

variable "backedns3bucketname" {
  type = string
}

variable "region" {
  type    = string
  default = "eu-west-2"
}