# main.tf (Root)

module "vpc" {
  source = "./modules/vpc"
}

module "networking" {
  source = "./modules/networking"
  vpc_id = module.vpc.vpc_id # Use output from VPC module, not var.vpc_id
}

module "alb" {
  source         = "./modules/alb"
  vpc_id         = module.vpc.vpc_id
  public_subnets = module.vpc.public_subnet_ids
  alb_sg_id      = module.networking.alb_sg_id
}

module "ecs" {
  source             = "./modules/ecs"
  # FIXED: All names on the left must match your ecs/variables.tf exactly
  public_subnets     = module.vpc.public_subnet_ids
  ecs_sg_id          = module.networking.ecs_sg_id
  blue_tg_arn        = module.alb.blue_tg_arn
  strapi_image       = var.strapi_image
  execution_role_arn = var.ecs_task_execution_role
}

module "codedeploy" {
  source = "./modules/codedeploy"

  # LEFT SIDE = variable name inside the module
  # RIGHT SIDE = the value being sent from the root
  ecs_cluster_name        = module.ecs.cluster_name
  ecs_service_name        = module.ecs.service_name
  alb_listener_arn        = module.alb.prod_listener_arn
  target_group_blue_name  = module.alb.blue_tg_name
  target_group_green_name = module.alb.green_tg_name
  codedeploy_role_arn     = var.codedeploy_service_role
}