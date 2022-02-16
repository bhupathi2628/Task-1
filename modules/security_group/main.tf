# Get ID of created Security Group
locals {
  sg_id = concat(
    aws_security_group.my_sg.*.id,
    [""],
  )[0]
}

# Security group with name
resource "aws_security_group" "my_sg" {
  count = var.create ? 1 : 0

  name        = var.name
  description = var.description
  vpc_id      = var.vpc_id

  tags = merge(
    var.tags,
    {
      "Name" = format("%s", var.name)
    },
  )
}

# Security group rules with "cidr_blocks"
resource "aws_security_group_rule" "ingress_with_cidr_blocks" {
  count = var.create ? length(var.ingress_with_cidr_blocks) : 0

  security_group_id = local.sg_id
  type              = "ingress"

  cidr_blocks = lookup(
    var.ingress_with_cidr_blocks[count.index],
    "cidr_blocks",
    {},
  )

  description = lookup(
    var.ingress_with_cidr_blocks[count.index],
    "description",
    null,
  )

  from_port = lookup(
    var.ingress_with_cidr_blocks[count.index],
    "from_port",
    "_",
  )
  to_port = lookup(
    var.ingress_with_cidr_blocks[count.index],
    "to_port",
    "_",
  )
  protocol = lookup(
    var.ingress_with_cidr_blocks[count.index],
    "protocol",
    "_",
  )
}
# End of ingress

# Egress - Maps of rules
#########################
resource "aws_security_group_rule" "egress_with_security_group_id" {
  count = var.create ? length(var.egress_with_security_group_id) : 0

  security_group_id = local.sg_id
  type              = "egress"

  source_security_group_id = var.egress_with_security_group_id[count.index]["security_group_id"]

  description = lookup(
    var.egress_with_security_group_id[count.index],
    "description",
    "Egress Rule",
  )

  from_port = lookup(
    var.egress_with_security_group_id[count.index],
    "from_port",
    "_",
  )
  to_port = lookup(
    var.egress_with_security_group_id[count.index],
    "to_port",
    "_"
  )
  protocol = lookup(
    var.egress_with_security_group_id[count.index],
    "protocol",
    "_"
  )
}

# Security group rules with "cidr_blocks"
resource "aws_security_group_rule" "egress_with_cidr_blocks" {
  count = var.create ? length(var.egress_with_cidr_blocks) : 0

  security_group_id = local.sg_id
  type              = "egress"

  cidr_blocks = split(
    ",",
    lookup(
      var.egress_with_cidr_blocks[count.index],
      "cidr_blocks",
      join(",", var.egress_cidr_blocks),
    ),
  )
  prefix_list_ids = var.egress_prefix_list_ids
  description = lookup(
    var.egress_with_cidr_blocks[count.index],
    "description",
    "Egress Rule",
  )

  from_port = lookup(
    var.egress_with_cidr_blocks[count.index],
    "from_port",
    "_",
  )
  to_port = lookup(
    var.egress_with_cidr_blocks[count.index],
    "to_port",
    "_",
  )
  protocol = lookup(
    var.egress_with_cidr_blocks[count.index],
    "protocol",
    "_",
  )
}
# End of egress
