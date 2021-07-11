//variables.tf
variable "region" {
  type = string
  default = "us-east-2"
}
variable "ami_id" {
    type = string
    default = "ami-00399ec92321828f5"
}
variable "instances_num" {
  type = string
  default = "2"
}
# variable "iam_profile_name" {
#   type = string
#   default = "ECR_user"
# }