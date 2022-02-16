locals {
  web_server_id                     = aws_instance.ec2_instance.*.id
  this_availability_zone            = compact(coalescelist(aws_instance.ec2_instance.*.availability_zone, [""]))
  this_key_name                     = compact(coalescelist(aws_instance.ec2_instance.*.key_name, [""]))
  this_public_dns                   = compact(coalescelist(aws_instance.ec2_instance.*.public_dns, [""]))
  this_public_ip                    = compact(coalescelist(aws_instance.ec2_instance.*.public_ip, [""]))
  this_primary_network_interface_id = compact(coalescelist(aws_instance.ec2_instance.*.primary_network_interface_id, [""]))
  this_private_dns                  = compact(coalescelist(aws_instance.ec2_instance.*.private_dns, [""]))
  this_private_ip                   = compact(coalescelist(aws_instance.ec2_instance.*.private_ip, [""]))
  this_placement_group              = compact(coalescelist(aws_instance.ec2_instance.*.placement_group, [""]))
  this_security_groups              = coalescelist(aws_instance.ec2_instance.*.security_groups, [""])
  this_vpc_security_group_ids       = coalescelist(flatten(aws_instance.ec2_instance.*.vpc_security_group_ids), [""])
  this_subnet_id                    = compact(coalescelist(aws_instance.ec2_instance.*.subnet_id, [""]))
  this_credit_specification         = flatten(aws_instance.ec2_instance.*.credit_specification)
  this_tags                         = coalescelist(aws_instance.ec2_instance.*.tags, [""])
  this_volume_tags                  = coalescelist(aws_instance.ec2_instance.*.volume_tags, [""])
  this_password_data                = coalescelist(aws_instance.ec2_instance.*.password_data, [""])
  this_id_count                     = length(aws_instance.ec2_instance.*.id)
}

output "id" {
  description = "List of IDs of instances"
  value       = local.web_server_id.*
}

output "availability_zone" {
  description = "List of availability zones of instances"
  value       = local.this_availability_zone
}

output "placement_group" {
  description = "List of placement groups of instances"
  value       = local.this_placement_group
}

output "key_name" {
  description = "List of key names of instances"
  value       = local.this_key_name
}

output "public_dns" {
  description = "List of public DNS names assigned to the instances. For EC2-VPC, this is only available if you've enabled DNS hostnames for your VPC"
  value       = local.this_public_dns
}

output "public_ip" {
  description = "List of public IP addresses assigned to the instances, if applicable"
  value       = local.this_public_ip
}

output "primary_network_interface_id" {
  description = "List of IDs of the primary network interface of instances"
  value       = local.this_primary_network_interface_id
}

output "private_dns" {
  description = "List of private DNS names assigned to the instances. Can only be used inside the Amazon EC2, and only available if you've enabled DNS hostnames for your VPC"
  value       = local.this_private_dns
}

output "private_ip" {
  description = "List of private IP addresses assigned to the instances"
  value       = local.this_private_ip
}

output "password_data" {
  description = "List of Base-64 encoded encrypted password data for the instance"
  value       = local.this_password_data
}

output "security_groups" {
  description = "List of associated security groups of instances"
  value       = local.this_security_groups
}

output "vpc_security_group_ids" {
  description = "List of associated security groups of instances, if running in non-default VPC"
  value       = local.this_vpc_security_group_ids
}

output "subnet_id" {
  description = "List of IDs of VPC subnets of instances"
  value       = local.this_subnet_id
}

output "credit_specification" {
  description = "List of credit specification of instances"
  value       = local.this_credit_specification
}

output "tags" {
  description = "List of tags of instances"
  value       = local.this_tags
}

output "volume_tags" {
  description = "List of tags of volumes of instances"
  value       = local.this_volume_tags
}

output "instance_count" {
  description = "Gives the count of instances"
  value       = local.this_id_count
}