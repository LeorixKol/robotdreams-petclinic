output "vpc_id" {
  description = "ID of the VPC"
  value       = module.vpc.vpc_id
}

output "public_instance_ip" {
  description = "Public IP of the public instance"
  value       = module.ec2.public_instance_ip
}

output "private_instance_ip" {
  description = "Private IP of the private instance"
  value       = module.ec2.private_instance_ip
}

output "ssh_command_public" {
  description = "SSH command for public instance"
  value       = "ssh -i ~/.ssh/${var.key_name}.pem ec2-user@${module.ec2.public_instance_ip}"
}

output "ssh_command_private" {
  description = "SSH command for private instance (through bastion)"
  value       = "ssh -i ~/.ssh/${var.key_name}.pem -o ProxyCommand=\"ssh -i ~/.ssh/${var.key_name}.pem -W %h:%p ec2-user@${module.ec2.public_instance_ip}\" ec2-user@${module.ec2.private_instance_ip}"
}