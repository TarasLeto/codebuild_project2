locals {
  config_defaults = {
      "name"            = var.name
      # "service_role"        = var.service_role
      # "test_status"           = "live"
      # "tags"                  = "env:production"
      "location"              = var.location
      "buildspec"             ="./codebuild/buildspecdir/buildspec.yml"
      # "token"               = var.token 
      # "vpc_id"              = module.vpc.vpc_id 
      # "private_subnet_ids"  = module.vpc.private_subnet_ids 
      # "private_subnet_arns" =var.private_subnet_arns
  
  }
codebuild_test_config = { for e in var.codebuild_test_config : e.name => merge(local.config_defaults, e) }
}
  
resource "aws_codebuild_project" "codebuild" {
  for_each = local.codebuild_test_config
  name          = each.value.name
  description   = "${var.name}-codebuild"
  build_timeout = "5"
  service_role  = aws_iam_role.codebuild_iam.arn

  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:4.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"


  }

  logs_config {
    cloudwatch_logs {
      group_name  = "${var.name}-codebuild"
      stream_name = "${var.name}-codebuild-log-stream"
    }
  }

  source {
    type            = "GITHUB"
    location        = each.value.location
    git_clone_depth = 1
    buildspec       = file(each.value.buildspec)
    

    git_submodules_config {
      fetch_submodules = true
    }
  }

  source_version = "master"

vpc_config {
    vpc_id = var.vpc_id

    subnets = [
        var.private_subnet_ids
    ]

    #   aws_subnet.example1.id,
    #   aws_subnet.example2.id,

    security_group_ids = [
     aws_security_group.codebuild_sg.id
    ]
  }

}
