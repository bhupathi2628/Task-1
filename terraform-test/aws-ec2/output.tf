output "aws_web_instance_id" {
  description = "This is aws ec2 id"
  value       = module.aws_ec2_web_server.id
}

output "my_web_sg" {
  description = "secuirty group id's"
  value       = module.mi-sg.security_group_id
}
