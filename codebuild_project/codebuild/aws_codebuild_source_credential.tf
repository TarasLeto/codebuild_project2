resource "aws_codebuild_source_credential" "githubConnect" {
  auth_type   = "PERSONAL_ACCESS_TOKEN"
  server_type = "GITHUB"
  token       = var.token
}