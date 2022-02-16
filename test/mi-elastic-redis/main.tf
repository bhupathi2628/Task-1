provider "aws" {
  region = "us-east-1"
}

module "redis" {
  source = "../../modules/elasticcache-redis"

  name_prefix           = "redis-demo-example"
  number_cache_clusters = 2
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

  subnet_ids = ["subnet-07a9f95f2e48a963c", "subnet-07afdee673da7ebe7","subnet-03c63a11c87be9ebd"]
  vpc_id     = "vpc-0113a3f75ad27276e"

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