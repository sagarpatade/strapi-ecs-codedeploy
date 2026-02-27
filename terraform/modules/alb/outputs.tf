output "blue_tg_arn" { value = aws_lb_target_group.blue.arn }
output "blue_tg_name" { value = aws_lb_target_group.blue.name }
output "green_tg_name" { value = aws_lb_target_group.green.name }
output "prod_listener_arn" { value = aws_lb_listener.prod.arn }


output "alb_dns_name" {
  value = aws_lb.main.dns_name
}