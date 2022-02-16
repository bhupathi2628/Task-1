# vpc
resource "aws_vpc" "main_vpc" {
  count = var.create_vpc ? 1 : 0
  cidr_block                       = var.vpc_cidr_block
  instance_tenancy                 = var.instance_tenancy
  enable_dns_hostnames             = var.enable_dns_hostnames
  enable_dns_support               = var.enable_dns_support
  enable_classiclink               = var.enable_classiclink
  enable_classiclink_dns_support   = var.enable_classiclink_dns_support
  assign_generated_ipv6_cidr_block = var.assign_generated_ipv6_cidr_block
  tags = merge(
    {
      "Name" = format("%s", var.name)
    },
    var.tags,
    var.vpc_tags,
  )
}

# public subnet
resource "aws_subnet" "public_subnet" {
  count                           = var.create_vpc && length(var.public_subnets) >= length(var.azs) ? length(var.public_subnets) : 0
  vpc_id                          = aws_vpc.main_vpc[0].id
  cidr_block                      = element(var.public_subnets, count.index)
  availability_zone               = length(regexall("[a-z]{2}", var.azs[count.index])) > 0 ? var.azs[count.index] : null
  availability_zone_id            = length(regexall("^[a-z]{2}-", element(var.azs, count.index))) == 0 ? element(var.azs, count.index) : null
  map_public_ip_on_launch         = var.map_public_ip_on_launch
  assign_ipv6_address_on_creation = var.public_subnet_assign_ipv6_address_on_creation == null ? var.assign_ipv6_address_on_creation : var.public_subnet_assign_ipv6_address_on_creation
  tags                            = { Name = "public_subnet-${count.index + 0}" }
}

# private subnet
resource "aws_subnet" "private_subnet" {
  count                           = var.create_vpc && length(var.private_subnets) >= length(var.azs) ? length(var.private_subnets) : 0
  vpc_id                          = aws_vpc.main_vpc[0].id
  cidr_block                      = element(var.private_subnets, count.index)
  availability_zone               = length(regexall("[a-z]{2}", var.azs[count.index])) > 0 ? var.azs[count.index] : null
  availability_zone_id            = length(regexall("^[a-z]{2}-", element(var.azs, count.index))) == 0 ? element(var.azs, count.index) : null
  map_public_ip_on_launch         = var.map_public_ip_on_launch
  assign_ipv6_address_on_creation = var.private_subnet_assign_ipv6_address_on_creation == null ? var.assign_ipv6_address_on_creation : var.private_subnet_assign_ipv6_address_on_creation
  tags                            = { Name = "private_subnet-${count.index + 0}" }
}

# elastic ip
resource "aws_eip" "nat_eip" {
  vpc  = true
  tags = merge(
    {
      "Name" = format("%s", var.name)
    },
    var.nat_gateway_tags,
  )

}

# internet gateway
resource "aws_internet_gateway" "i_gw" {
  count = var.create_vpc && length(var.public_subnets) > 0 ? 1 : 0

  vpc_id = aws_vpc.main_vpc[0].id

  tags = merge(
    {
      "Name" = format("%s", var.name)
    },
    var.tags,
    var.igw_tags,
  )
}

# nat gateway
resource "aws_nat_gateway" "n_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet[0].id
  tags          = merge(
    { 
      "Name" = format("%s", var.name)
       }, 
       var.tags,
       var.nat_gateway_tags, 
    )
}

# route tables and thier routes
resource "aws_route_table" "public_rt" {
  count = var.create_vpc && length(var.public_subnets) > 0 ? 1 : 0
  vpc_id = aws_vpc.main_vpc[0].id
    route = [{
    cidr_block                 = "0.0.0.0/0"
    gateway_id                 = aws_internet_gateway.i_gw[0].id
    egress_only_gateway_id     = ""
    instance_id                = ""
    ipv6_cidr_block            = ""
    local_gateway_id           = ""
    nat_gateway_id             = ""
    network_interface_id       = ""
    transit_gateway_id         = ""
    vpc_endpoint_id            = ""
    vpc_peering_connection_id  = ""
    carrier_gateway_id         = ""
    destination_prefix_list_id = ""

  }]
  tags = merge(
    {
      "Name" = format("%s", var.name)
    },
    var.tags,
    var.public_route_table_tags,
  )
}

resource "aws_route_table" "private_rt" {
  count = var.create_vpc && length(var.private_subnets) > 0 ? 1 : 0
  vpc_id = aws_vpc.main_vpc[0].id
    route = [{
    cidr_block                 = "0.0.0.0/0"
    gateway_id                 = ""
    egress_only_gateway_id     = ""
    instance_id                = ""
    ipv6_cidr_block            = ""
    local_gateway_id           = ""
    nat_gateway_id             = aws_nat_gateway.n_gw.id
    network_interface_id       = ""
    transit_gateway_id         = ""
    vpc_endpoint_id            = ""
    vpc_peering_connection_id  = ""
    carrier_gateway_id         = ""
    destination_prefix_list_id = ""
  }]
  tags = merge(
    {
     "Name" = format("%s", var.name)
      },
      var.tags, 
      var.private_route_table_tags,
       )
}

# route table association
resource "aws_route_table_association" "private" {
  count          = length(var.private_subnets) > 0 ? length(var.private_subnets) : 0
  subnet_id      = aws_subnet.private_subnet[count.index +0].id
  route_table_id = aws_route_table.private_rt[0].id
}

resource "aws_route_table_association" "public" {
  count          = length(var.public_subnets) > 0 ? length(var.public_subnets) : 0
  subnet_id      = aws_subnet.public_subnet[count.index +0].id
  route_table_id = aws_route_table.public_rt[0].id
}