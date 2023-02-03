data "aws_availability_zones" "this" {}
locals {
  name         = "${var.name}-network"
  cluster_name = "${var.name}-${var.tag_environment}-eks-cluster"

  tags = {
    Name        = "${var.name}-${var.tag_environment}-vpc"
    Terraform   = "true"
    Environment = var.tag_environment
  }
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.14.0"

  name = "${var.name}-${var.tag_environment}-vpc"
  cidr = "${var.cidr_block}.0.0/16"

  #azs = ["${var.aws_region}c", "${var.aws_region}d", "${var.aws_region}e"] #
  azs             = ["${var.aws_region}b", "${var.aws_region}c", "${var.aws_region}a"] #
  private_subnets = ["${var.cidr_block}.0.0/20", "${var.cidr_block}.16.0/20", "${var.cidr_block}.32.0/20"]
  public_subnets  = ["${var.cidr_block}.128.0/20", "${var.cidr_block}.144.0/20", "${var.cidr_block}.160.0/20"]

  enable_dns_support = true

  enable_dns_hostnames = true
  enable_nat_gateway   = true
  single_nat_gateway   = var.single_nat_gateway

  enable_flow_log                      = true
  create_flow_log_cloudwatch_iam_role  = true
  create_flow_log_cloudwatch_log_group = true

  public_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                      = 1
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"             = 1
  }

  tags = local.tags 
  

}

