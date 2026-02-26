resource "aws_ecs_cluster" "main" {
  name = "strapi-cluster"
}

resource "aws_ecs_task_definition" "strapi" {
  family                   = "strapi-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "512"
  memory                   = "1024"

  # Use variables for ARNs to keep the module flexible
  execution_role_arn       = var.execution_role_arn
  task_role_arn            = var.execution_role_arn

  container_definitions = jsonencode([{
    name      = "strapi-app"
    image     = var.strapi_image
    essential = true
    portMappings = [{
      containerPort = 1337
      hostPort      = 1337
      protocol      = "tcp"
    }]
    # FIX: Environment must be INSIDE the container definition object
    environment = [
      { name = "NODE_ENV", value = "production" },
      { name = "DATABASE_CLIENT", value = "sqlite" },
      { name = "DATABASE_FILENAME", value = ".tmp/data.db" }
    ]
  }])
}

resource "aws_ecr_repository" "strapi" {
  name                 = "strapi-app"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

output "repository_url" {
  value = aws_ecr_repository.strapi.repository_url
}

resource "aws_ecs_service" "strapi" {
  name            = "strapi-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.strapi.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  deployment_controller { type = "CODE_DEPLOY" }

  network_configuration {
    subnets          = var.public_subnets
    security_groups  = [var.ecs_sg_id]
    assign_public_ip = true 
  }

  load_balancer {
    target_group_arn = var.blue_tg_arn
    container_name   = "strapi-app"
    container_port   = 1337
  }

  lifecycle {
    ignore_changes = [task_definition, load_balancer]
  }
}