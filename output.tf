# VPC output
output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.aws_vpc.aws_vpc_id
}

output "aws_web_instance_id" {
  description = "This is aws ec2 id"
  value       = module.aws_ec2_web_server.id
}

output "my_web_sg" {
  description = "secuirty group id's"
  value       = module.mi-sg.security_group_id
}

output "public_web_subnets" {
  description = "private subnet ids"
  value       = module.aws_vpc.public_subnets[*]
}

output "private_app_subnets" {
  description = "private subnet ids"
  value       = module.aws_vpc.private_subnets[*]
}