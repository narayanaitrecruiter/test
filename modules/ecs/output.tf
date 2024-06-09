output "ecs_cluster_name" {
  value = aws_ecs_cluster.default.name
}


output "ecs_service_name" {
  value = aws_ecs_service.service.name
}