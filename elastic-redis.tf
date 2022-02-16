
module "redis" {
  source = "github.com/bhupathi2628/Task-1.git//modules/elasticcache-redis?ref=master"

  name_prefix           = "redis-demo-example"
  number_cache_clusters = 1
  node_type             = "cache.t3.micro"
  engine_version            = "5.0.6"
  port                      = 6379
  snapshot_retention_limit  = 7
  final_snapshot_identifier = "redis-final-snapshot-name"

  automatic_failover_enabled = true
  multi_az_enabled           = true

  at_rest_encryption_enabled = true
  transit_encryption_enabled = true
  auth_token                 = "1234567890asdfghjkl"

  apply_immediately = true
  family            = "redis6.x"
  description       = "Test elasticache redis."

  subnet_ids =  module.aws_vpc.private_subnets
  vpc_id     = module.aws_vpc.aws_vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]

  parameter = [
    {
      name  = "repl-backlog-size"
      value = "16384"
    }
  ]

  tags = {
    Project = "Test"
  }
}