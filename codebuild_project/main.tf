module "vpc" {
  source             = "./vpc"
  aws_region         = var.aws_region
  cidr_block         = var.cidr_block
  name               = var.name
  tag_environment    = var.tag_environment
  single_nat_gateway = var.single_nat_gateway
  # private_subnet_ids = {}
}

module "codebuild" {
  depends_on = [
    module.vpc
  ]
  source ="./codebuild"
  name = var.name
  buildspec = var.buildspec
  location = var.location
  token = var.token
  vpc_id = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids 
  private_subnet_arns = var.private_subnet_arns
  codebuild_test_config= var.codebuild_test_config
  
}

# locals {
#   directory_config = "./buildspecdir"
# }

# resource "kubernetes_config_map" "example" {
#   metadata {
#     name = "test"
#   }

#   data = {
#     for f in fileset(local.directory_config, "*.txt") :
#     f => file(join("/", [local.directory_config, f]))
#   }
# }