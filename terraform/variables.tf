variable "region" {
  type    = string
  default = "us-east-1"
}

variable "strapi_image" {
  type        = string
  description = "The Docker image URI for the Strapi app"
}

variable "ecs_task_execution_role" {
  type        = string
  description = "The ARN of the company-provided ECS execution role"
}

variable "codedeploy_service_role" {
  type        = string
  description = "The ARN of the company-provided CodeDeploy role"
}
