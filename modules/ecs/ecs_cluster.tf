########################################################################################################################
## Creates an ECS Cluster
########################################################################################################################

resource "aws_ecs_cluster" "default" {
  name = "${var.namespace}_ECSCluster_${var.environment}"

  tags = {
    Name     = "${var.namespace}_ECSCluster_${var.environment}"

  }
}

output "ecs_cluster_name" {
  value = aws_ecs_cluster.default.name
}

output "ecs_cluster_id" {
  value = aws_ecs_cluster.default.id
}

