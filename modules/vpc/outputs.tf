output "main_vpc" {
  value = aws_vpc.main
}

output "default_security_group_id" {
  value = aws_default_security_group.default.id
}
