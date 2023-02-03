variable "name" {} 
variable "buildspec" {}
variable "location" {}
variable "token" {}
variable "vpc_id" {}
variable "private_subnet_ids" {}
variable "private_subnet_arns" {}
variable "codebuild_test_config" {
    type = list(map(string))
} 
