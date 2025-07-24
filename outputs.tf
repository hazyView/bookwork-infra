output "alb_dns_name" {
    value = aws_lb.main.dns_name
}

output "api_ecr_url" {
    value = aws_ecr_repository.api.repository_url
}

output "frontend_ecr_url" {
    value = aws_ecr_repository.frontend.repository_url
}