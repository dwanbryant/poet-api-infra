resource "aws_ecr_repository" "fastapi_repo" {
  name = "fastapi-poet-api"
}

output "ecr_repository_url" {
  value = aws_ecr_repository.fastapi_repo.repository_url
}
