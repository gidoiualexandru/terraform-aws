output "security_group_id" {
  description = "ID of the EC2 security group"
  value       = aws_security_group.instance.id
}

output "launch_template_id" {
  description = "ID of the launch template"
  value       = aws_launch_template.instance.id
}

output "autoscaling_group_name" {
  description = "Name of the autoscaling group"
  value       = aws_autoscaling_group.main.name
} 