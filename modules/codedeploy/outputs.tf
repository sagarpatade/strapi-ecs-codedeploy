output "codedeploy_app_name" {
  value = aws_codedeploy_app.strapi.name # Change 'main' to 'strapi'
}

output "codedeploy_deployment_group_name" {
  value = aws_codedeploy_deployment_group.strapi.deployment_group_name # Change 'main' to 'strapi'
}