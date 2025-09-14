variable "ec2_instance_type" {
  description = "Type of instance to create"
  type        = string
  default     = "t3.micro"
}   
variable "ec2_def_root_storage_size" {
  description = "Root storage size in GB"
  type        = number
  default     = 15
}   
variable "ec2_ami_id" {     
  description = "AMI ID for the instance"
  type        = string
  default     = "ami-0cfde0ea8edd312d4"  # ubuntu 20.04 in us-east-1
} 
variable "env" {
  description = "Environment tag for resources"
  type        = string
  default     = "dev"
}