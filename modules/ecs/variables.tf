variable "public_subnets" { 
  type        = list(string)
  description = "The public subnets where the ECS tasks will run"
}

variable "ecs_sg_id" { 
  type        = string 
}

variable "blue_tg_arn" { 
  type        = string 
}

variable "strapi_image" {
  type        = string
  description = "The URI of the Docker image from ECR or Docker Hub"
}

variable "execution_role_arn" {
  type        = string
  description = "The ARN of the IAM role for ECS execution"
}