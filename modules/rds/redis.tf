
resource "aws_elasticache_cluster" "redis_server" {
  cluster_id           = "redis-server"
  engine               = "redis"
  engine_version    = var.engine_version_redis
  node_type           = "cache.t3.micro"
  num_cache_nodes     = 1
  #parameter_group_name = "default.redis6.x"
  parameter_group_name = aws_elasticache_parameter_group.custom_redis_parameters.name
  subnet_group_name    = aws_elasticache_subnet_group.redis_subnet_group.name
  security_group_ids   = [aws_security_group.allow_redis.id]
  tags = {
    Name = "qa-redis-server"
  }
}




# Create the Redis Subnet Group
resource "aws_elasticache_subnet_group" "redis_subnet_group" {
  name       = "redis-subnet-group"
  subnet_ids = var.subnet_ids
}
# Create the CloudWatch Log Group
resource "aws_cloudwatch_log_group" "redis_log_group" {
  name              = "/redis-server"
  retention_in_days = 7
  tags = {
        Environment = "QA"
        Project     = "qa-redis-server"
    }
}


resource "aws_security_group" "allow_redis" {
  name        = "allow_redis"
  description = "Allow inbound traffic for Redis"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_redis"
  }
}


resource "aws_elasticache_parameter_group" "custom_redis_parameters" {
  name   = "custom-redis-parameters"
  family = "redis6.x"

  parameter {
    name  = "maxmemory-policy"
    value = "allkeys-lru"
  }
  # Add any other custom parameter configurations as needed
}