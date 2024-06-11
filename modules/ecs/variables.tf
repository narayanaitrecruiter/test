

########################################################################################################################
## EC2 Computing variables
########################################################################################################################

variable "instance_type" {
  description = "Instance type for EC2"
  default     = "t3.micro"
  type        = string
}

########################################################################################################################
## ECS variables
########################################################################################################################

variable "ecs_task_desired_count" {
  description = "How many ECS tasks should run in parallel"
  type        = number
  default     = 2
}

variable "ecs_task_min_count" {
  description = "How many ECS tasks should minimally run in parallel"
  default     = 2
  type        = number
}

variable "ecs_task_max_count" {
  description = "How many ECS tasks should maximally run in parallel"
  default     = 10
  type        = number
}

variable "ecs_task_deployment_minimum_healthy_percent" {
  description = "How many percent of a service must be running to still execute a safe deployment"
  default     = 50
  type        = number
}

variable "ecs_task_deployment_maximum_percent" {
  description = "How many additional tasks are allowed to run (in percent) while a deployment is executed"
  default     = 100
  type        = number
}

variable "cpu_target_tracking_desired_value" {
  description = "Target tracking for CPU usage in %"
  default     = 70
  type        = number
}

variable "memory_target_tracking_desired_value" {
  description = "Target tracking for memory usage in %"
  default     = 80
  type        = number
}

variable "maximum_scaling_step_size" {
  description = "Maximum amount of EC2 instances that should be added on scale-out"
  default     = 5
  type        = number
}

variable "minimum_scaling_step_size" {
  description = "Minimum amount of EC2 instances that should be added on scale-out"
  default     = 1
  type        = number
}

variable "target_capacity" {
  description = "Amount of resources of container instances that should be used for task placement in %"
  default     = 100
  type        = number
}

variable "container_port" {
  description = "Port of the container"
  type        = number
  default     = 80
}

variable "cpu_units" {
  description = "Amount of CPU units for a single ECS task"
  default     = 100
  type        = number
}

variable "memory" {
  description = "Amount of memory in MB for a single ECS task"
  default     = 256
  type        = number
}


variable "container_definitions_file" {
  description = "Path to the container definitions file"
  type        = string
  default     = "modules/ecs/task-definitions/task-def1.json"
}

variable "task_definition_family" {
  description = "Family name of the ECS task definition"
  type        = string
  default     = "my-task-family"
}


########################################################################################################################
## Cloudwatch
########################################################################################################################

variable "retention_in_days" {
  description = "Retention period for Cloudwatch logs"
  default     = 7
  type        = number
}

########################################################################################################################
## Autoscaling Group
########################################################################################################################

variable "autoscaling_max_size" {
  description = "Max size of the autoscaling group"
  default     = 6
  type        = number
}

variable "autoscaling_min_size" {
  description = "Min size of the autoscaling group"
  default     = 2
  type        = number
}

########################################################################################################################
## ALB
########################################################################################################################


variable "healthcheck_endpoint" {
  description = "Endpoint for ALB healthcheck"
  type        = string
  default     = "/"
}

variable "healthcheck_matcher" {
  description = "HTTP status code matcher for healthcheck"
  type        = string
  default     = "200"
}

########################################################################################################################
## Service variables
########################################################################################################################

variable "namespace" {
  description = "Namespace for the resources"
  default     = "QA-cluster"
  type        = string
  
}

variable "environment" {
  description = "Environment for deployment (like dev or staging)"
  default     = "QA-cluster"
  type        = string
}

variable "vpc_id" {
  description = "default value for vpc"
  type = string
  
}

variable "subnet_ids" {
  description = "default value for subnet"
  type = list(string)
}

variable "keypair" {
  description = "Keypair for EC2 instances"
  type        = string
  
}