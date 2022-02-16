resource "aws_elasticache_replication_group" "redis" {
  engine = var.global_replication_group_id == null ? "redis" : null


  security_group_ids   = var.security_group_ids

  availability_zones    = var.availability_zones
  replication_group_id  = var.global_replication_group_id == null ? "${var.name_prefix}redis" : "${var.name_prefix}redisreplica"
  node_type             = var.global_replication_group_id == null ? var.node_type : null

  engine_version = var.global_replication_group_id == null ? var.engine_version : null
  port           = var.port

  maintenance_window         = var.maintenance_window
  snapshot_window            = var.snapshot_window
  snapshot_retention_limit   = var.snapshot_retention_limit

  auto_minor_version_upgrade = var.auto_minor_version_upgrade

  at_rest_encryption_enabled  = var.global_replication_group_id == null ? var.at_rest_encryption_enabled : null
  transit_encryption_enabled  = var.global_replication_group_id == null ? var.transit_encryption_enabled : null
  kms_key_id                  = var.kms_key_id

  apply_immediately = var.apply_immediately

  replication_group_description = var.description

  notification_topic_arn = var.notification_topic_arn

  dynamic "cluster_mode" {
    for_each = var.cluster_mode_enabled ? [1] : []
    content {
      replicas_per_node_group = var.replicas_per_node_group
      num_node_groups         = var.num_node_groups
    }
  }

  tags = merge(
    {
      "Name" = "${var.name_prefix}-redis"
    },
    var.tags,
  )
}
