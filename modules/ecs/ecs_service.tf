########################################################################################################################
## Creates ECS Service
########################################################################################################################

resource "aws_ecs_service" "service" {
  name                               = "${var.namespace}_ECS_Service_${var.task_definition_family}"
  iam_role                           = aws_iam_role.ecs_service_role.arn
  cluster                            = aws_ecs_cluster.default.id
  task_definition                    = aws_ecs_task_definition.default.arn
  desired_count                      = var.ecs_task_desired_count
  deployment_minimum_healthy_percent = var.ecs_task_deployment_minimum_healthy_percent
  deployment_maximum_percent         = var.ecs_task_deployment_maximum_percent

  load_balancer {
    target_group_arn = aws_alb_target_group.service_target_group.arn
    container_name   = var.task_definition_family
    container_port   = var.container_port
  }

  ordered_placement_strategy {
    type  = "spread"
    field = "attribute:ecs.availability-zone"
  }

  ordered_placement_strategy {
    type  = "binpack"
    field = "memory"
  }

  lifecycle {
    ignore_changes = [desired_count]
  }

  tags = {
    name = var.environment
  }
}

output "ecs_service_name" {
  value = aws_ecs_service.service.name
}

########################################################################################################################
## Creates ECS Task Definition
########################################################################################################################

resource "aws_ecs_task_definition" "default" {
  family             = var.task_definition_family
  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn      = aws_iam_role.ecs_task_iam_role.arn
  container_definitions = file(var.container_definitions_file)

# task definition can be mention in the file name or in different folder.

  # container_definitions = jsonencode([
  #   {
  #     name      = var.service_name
  #     image     = "${aws_ecr_repository.ecr.repository_url}:${var.hash}"
  #     cpu       = var.cpu_units
  #     memory    = var.memory
  #     essential = true
  #     portMappings = [
  #       {
  #         containerPort = var.container_port
  #         hostPort      = 0
  #         protocol      = "tcp"
  #       }
  #     ]
  #     logConfiguration = {
  #       logDriver = "awslogs",
  #       options = {
  #         "awslogs-group"         = aws_cloudwatch_log_group.log_group.name,
  #         "awslogs-region"        = var.region,
  #         "awslogs-stream-prefix" = "app"
  #       }
  #     }
  #   }
  # ])

  tags = {
    name =  var.environment
  }
}

