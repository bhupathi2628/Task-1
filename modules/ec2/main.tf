locals {
  is_t_instance_type = replace(var.instance_type, "/^t(2|3|3a){1}\\..*$/", "1") == "1" ? true : false
}

resource "aws_instance" "ec2_instance" {
  count = var.instance_count

  ami           = var.ami
  instance_type = var.instance_type
  subnet_id                   = element(var.subnet_id, count.index)
  key_name                    = var.key_name
  monitoring                  = var.monitoring
  get_password_data           = var.get_password_data
  vpc_security_group_ids      = var.vpc_security_group_ids
  iam_instance_profile        = var.iam_instance_profile
  associate_public_ip_address = var.associate_public_ip_address
  private_ip                  = length(var.private_ips) > 0 ? element(var.private_ips, count.index) : var.private_ip
  ipv6_address_count          = var.ipv6_address_count
  ipv6_addresses              = var.ipv6_addresses
  ebs_optimized               = var.ebs_optimized

  lifecycle {
    ignore_changes = [user_data, ami, ebs_optimized, disable_api_termination, key_name]
  }

  dynamic "root_block_device" {
    for_each = var.root_block_device
    content {
      delete_on_termination = lookup(root_block_device.value, "delete_on_termination", null)
      encrypted             = lookup(root_block_device.value, "encrypted", null)
      iops                  = lookup(root_block_device.value, "iops", null)
      kms_key_id            = lookup(root_block_device.value, "kms_key_id", null)
      volume_size           = lookup(root_block_device.value, "volume_size", null)
      volume_type           = lookup(root_block_device.value, "volume_type", null)
    }
  }

  dynamic "ebs_block_device" {
    for_each = var.ebs_block_device
    content {
      delete_on_termination = lookup(ebs_block_device.value, "delete_on_termination", null)
      device_name           = lookup(ebs_block_device.value, "device_name", null)
      encrypted             = lookup(ebs_block_device.value, "encrypted", null)
      iops                  = lookup(ebs_block_device.value, "iops", null)
      kms_key_id            = lookup(ebs_block_device.value, "kms_key_id", null)
      snapshot_id           = lookup(ebs_block_device.value, "snapshot_id", null)
      volume_size           = lookup(ebs_block_device.value, "volume_size", null)
      volume_type           = lookup(ebs_block_device.value, "volume_type", null)
    }
  }

  dynamic "ephemeral_block_device" {
    for_each = var.ephemeral_block_device
    content {
      device_name  = ephemeral_block_device.value.device_name
      no_device    = lookup(ephemeral_block_device.value, "no_device", null)
      virtual_name = lookup(ephemeral_block_device.value, "virtual_name", null)
    }
  }

  dynamic "credit_specification" {
    for_each = length(keys(var.credit_specification)) == 0 ? [] : [var.credit_specification]
    content {
      cpu_credits = lookup(credit_specification.value, "cpu_credits", null)
    }
  }

  dynamic "timeouts" {
    for_each = length(keys(var.timeouts)) == 0 ? [] : [var.timeouts]

    content {
      create = lookup(timeouts.value, "load_balancer_create_timeout", 10)
      delete = lookup(timeouts.value, "load_balancer_delete_timeout", 10)
      update = lookup(timeouts.value, "load_balancer_update_timeout", 10)
    }
  }

  source_dest_check                    = var.source_dest_check
  disable_api_termination              = var.disable_api_termination
  instance_initiated_shutdown_behavior = var.instance_initiated_shutdown_behavior
  placement_group                      = var.placement_group
  tenancy                              = var.tenancy

  tags = merge(
    {
      Name = var.instance_count > 1 ? format("%s-%d", var.name, count.index) : var.name
    },
    var.tags,
  )

  volume_tags = merge(
    {
      "Name" = var.instance_count > 1 ? format("vol-%s-%d", var.name, count.index) : format("vol-%s", var.name)
    },
    var.volume_tags,
  )
}





