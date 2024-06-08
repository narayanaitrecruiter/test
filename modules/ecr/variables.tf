########################################################################################################################
## ECR
########################################################################################################################

variable "ecr_force_delete" {
  description = "Forces deletion of Docker images before resource is destroyed"
  default     = true
  type        = bool
}

variable "hash" {
  description = "Task hash that simulates a unique version for every new deployment of the ECS Task"
  type        = string
  default     = "1.0"
}

variable "task_definition_family" {
  description = "Family name of the ECS task definition"
  type        = string
  default     = "my-task-family"
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

variable "" {
  
}