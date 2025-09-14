# output for out 
# output "ec2_public_id" {
#   description = "Public IP of the EC2 instance"
#   value       = aws_instance.my-ec2[*].public_ip
# }
# output "ec2_public_dns" {
#     description = "Public DNS of the EC2 instance"
#     value       = aws_instance.my-ec2[*].public_dns
# }
#output for each
output "ec2_instance_ids" {
  description = "IDs of the EC2 instances"
  value       = [for instance in aws_instance.my-ec2 : instance.id]
}