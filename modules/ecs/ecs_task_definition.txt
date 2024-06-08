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

