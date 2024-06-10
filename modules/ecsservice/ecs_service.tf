########################################################################################################################
## Creates ECS Service
########################################################################################################################

resource "aws_ecs_service" "service" {
  name                               = "${var.namespace}_ECS_Service_${var.task_definition_family}"
  iam_role                           = aws_iam_role.ecs_service_role.arn
  cluster                            = var.cluster_id
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


########################################################################################################################
## Creates ECS Task Definition
########################################################################################################################

resource "aws_ecs_task_definition" "default" {
  family                   = var.task_definition_family
  network_mode             = "bridge"
  requires_compatibilities = ["EC2"]
  cpu                      = "512"
  memory                   = "256"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([
    {
      name  = var.task_definition_family
      image = var.container_image
      portMappings = [
        {
          containerPort = var.container_port,
          hostPort      = var.host_port,
          protocol      = "tcp"
        },
      ]
    }
  ])
}


