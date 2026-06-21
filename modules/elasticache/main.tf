resource "aws_elasticache_subnet_group" "this" {
  name       = "${var.identifier}-subnet-group"
  subnet_ids = var.subnet_ids
  tags       = var.tags
}

resource "aws_security_group" "this" {
  name        = "${var.identifier}-sg"
  description = "ElastiCache Redis Security Group"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 6379
    to_port         = 6379
    protocol        = "tcp"
    security_groups = var.allowed_security_group_ids
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}

resource "aws_elasticache_cluster" "this" {
  cluster_id           = var.identifier
  engine               = "redis"
  engine_version        = var.engine_version
  node_type            = var.node_type
  num_cache_nodes      = 1
  port                 = 6379

  subnet_group_name   = aws_elasticache_subnet_group.this.name
  security_group_ids  = [aws_security_group.this.id]

  # Single node, no Multi-AZ, no automatic failover — matches the
  # single-environment / cost-conscious posture used for RDS above.
  # A real prod environment would use a replication group with
  # automatic_failover_enabled instead of a single cluster node.
  apply_immediately = true

  tags = var.tags
}