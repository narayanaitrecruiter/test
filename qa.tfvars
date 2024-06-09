aws_ecs_service_configuration = {
  "payment" = {
    task_definition_family = "payment"
    container_port         = 80
    cpu                    = 256
    memory                 = 512
    desired_count          = 2
    container_definitions  = modules / ecs / task-definitions / payment.json

  },
  "auth" = {
    task_definition_family = "auth"
    container_port         = 80
    cpu                    = 256
    memory                 = 512
    desired_count          = 2
    container_definitions  = modules / ecs / task-definitions / auth.json

  }
}