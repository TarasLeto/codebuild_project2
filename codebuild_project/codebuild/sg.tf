resource "aws_security_group" "codebuild_sg" {
  name        = "CodeBuild_SG"
  description = "Security Group for CodeBuild"
  vpc_id = var.vpc_id


  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }


   egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }


  tags = {
    Service = "CodeBuild"
    Terraform = "True"
  }
}
