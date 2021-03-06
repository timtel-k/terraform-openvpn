output "tags" {
  description = "List of tags of instances"
  value       = aws_instance.ldap.tags
}

output "public_dns" {
  description = "List of public DNS names assigned to the instances. For EC2-VPC, this is only available if you've enabled DNS hostnames for your VPC"
  value       = aws_instance.ldap.public_dns
}

output "public_ip" {
  description = "List of public IP addresses assigned to the instances, if applicable"
  value       = aws_instance.ldap.public_ip
}

output "primary_network_interface_id" {
  description = "List of IDs of the primary network interface of instances"
  value       = aws_instance.ldap.primary_network_interface_id
}

output "private_dns" {
  description = "List of private DNS names assigned to the instances. Can only be used inside the Amazon EC2, and only available if you've enabled DNS hostnames for your VPC"
  value       = aws_instance.ldap.private_dns
}

output "private_ip" {
  description = "List of private IP addresses assigned to the instances"
  value       = aws_instance.ldap.private_ip
}

