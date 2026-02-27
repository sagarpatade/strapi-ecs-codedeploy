

output "ecs_cluster_name" {
  value = module.ecs.cluster_name
}

output "alb_url" {
  value = module.alb.alb_dns_name # Match the name from the module's output
}

output "alb_dns_name" {
  value = module.alb.alb_dns_name # Use 'alb_dns_name' not 'dns_name'
}