variable "AWS_ACCESS_KEY"{}
variable "AWS_SECRET_KEY"{}
variable "AWS_REGION"{
 default = "us-west-1"
}
variable "AMIS"{
 type = "map"
 default = {
  us-west-1 = "ami-0689ca7fe00282a37"
#  eu-west-1 = "ami-04ee3f20dbc50ab21"
#  us-west-2 = "ami-0ba5dfee72d5bb9a1"
 }
}
variable "PATH_TO_PUBLIC_KEY" {}
variable "PATH_TO_PRIVATE_KEY" {}
variable "INSTANCE_USERNAME" {}
