variable "name" {
  type = string
  default = "codebuildProject"
}
variable "my_access_key" {
    type= string
	default = "AKIATZGP3ZVGCHJIU4LY"
}
variable "my_secret_key" {
	type=string
   default = "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"
   }
variable "cidr" {
  description = "(Optional) The IPv4 CIDR block for the VPC. CIDR can be explicitly set or it can be derived from IPAM using `ipv4_netmask_length` & `ipv4_ipam_pool_id`"
  type        = string
  default     = "0.0.0.0/0"
}
variable "aws_region" {
  type=string
  default = "us-east-1"
}
variable "buildspec" {
  type = string
  default ="./buildspecdir/buildspec.yml"
}
variable "location" {
  type=string
  default ="https://github.com/TarasLeto/aws-codebuild-terraform"
}
variable token {
  type = string
  default= "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"
}
variable single_nat_gateway {
  type = bool 
  default = "true"
}
variable "cidr_block" {
  type = string
  default = "10.10"
}
variable "tag_environment" {
  type = string
  default = "test"
  
}
variable "private_subnet_arns" {
  type = string
  default = ""
}
variable "iam_username" {
  type = string
  default = ""
}

variable "service_role" {
  type = string
  default = ""
}

variable "codebuild_test_config" {
  type = list(map(string))
  default = [
    {
      "name"        = "codebuild_java"
      # "service_role"      = var.service_role
      # "test_status"         = "live"
      # "tags"                = "env:java"
      "location"            = "https://github.com/TarasLeto/codebuild_terraform_java.git"
      "buildspec"           = "./codebuild/buildspecdir/buildspecJava.yml"
      # "token"               = var.token 
      # "vpc_id"              = module.vpc.vpc_id 
      # "private_subnet_ids"  = module.vpc.private_subnet_ids 
      # "private_subnet_arns" = var.private_subnet_arns
    } 
    ,
    { 
      "name"        = "codebuild_npm"
      # "service_role"      = var.service_role
      # "test_status"         = "live"
      # "tags"                = "env:npm"
      "location"            = "https://github.com/TarasLeto/codebuild_terraformNPM.git"
      "buildspec"           = "./codebuild/buildspecdirnpm/buildspecnpm.yml"
      # "token"               = var.token 
      # "vpc_id"              = module.vpc.vpc_id 
      # "private_subnet_ids"  = module.vpc.private_subnet_ids 
      # "private_subnet_arns" = var.private_subnet_arns
     },
 { 
      "name"        = "codebuild_python"
      # "service_role"      = var.service_role
      # "test_status"         = "live"
      # "tags"                = "env:python"
      "location"            = "https://github.com/TarasLeto/codebuild_terraform_python.git"
      "buildspec"           = "./codebuild/buildspecdirpython/buidspecpy.yml"
      # "token"               = var.token 
      # "vpc_id"              = module.vpc.vpc_id 
      # "private_subnet_ids"  = module.vpc.private_subnet_ids 
      # "private_subnet_arns" = var.private_subnet_arns
  }
     
  ]
}

    
    