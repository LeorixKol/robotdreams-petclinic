output "public_instance_id" {
  description = "ID of the public instance"
  value       = aws_instance.public.id
}

output "private_instance_id" {
  description = "ID of the private instance"
  value       = aws_instance.private.id
}

output "public_instance_ip" {
  description = "Public IP of the public instance"
  value       = aws_instance.public.public_ip
}

output "private_instance_ip" {
  description = "Private IP of the private instance"
  value       = aws_instance.private.private_ip
}