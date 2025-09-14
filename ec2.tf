# Create a key pair
resource aws_key_pair mykey {
  key_name   = "terra-key-ec2-22"
  public_key = file("terra-key-ec2.pub")
  tags = {

  Environment = var.env
  }
}
resource aws_default_vpc default {

} 
resource aws_security_group my-sg{
    name = "${var.env}-automate-sg"
    description = "this will add by terraform "
    vpc_id = aws_default_vpc.default.id
    ingress {
         from_port = 22
         to_port = 22
         protocol = "tcp"
         cidr_blocks = ["0.0.0.0/0"]
}  
 #inbound 
    ingress {
         from_port = 80
         to_port = 80
         protocol = "tcp"
         cidr_blocks = ["0.0.0.0/0"]
}
     ingress {
         from_port = 8000
         to_port = 8000
         protocol = "tcp"
         cidr_blocks = ["0.0.0.0/0"]
}   #outbound 
     egress {
         from_port = 0
         to_port = 0
         protocol = "-1"
         cidr_blocks = ["0.0.0.0/0"]
}
    tags = {
        Name = "${var.env}-automate-sg"
    }
}  # Create an EC2 instance  
resource aws_instance my-ec2 {
  for_each = tomap({

    emaan-small= "t3.small"
    
    }) # meta argument
   depends_on = [aws_security_group.my-sg, aws_key_pair.mykey]  
   ami = var.ec2_ami_id # ubuntu 20.04 in us-east-1
   instance_type = each.value
   key_name      = aws_key_pair.mykey.key_name
   security_groups = [aws_security_group.my-sg.name]
   user_data = file("${path.module}/install_nginx.sh")
   root_block_device {
      volume_size =  var.env=="prd" ? 20 : var.ec2_def_root_storage_size
      volume_type = "gp3"
      delete_on_termination = true
   }
   tags = {
    Name = each.key
    Environment = var.env
  }
} 
# resource "aws_instance" "my-ec2-2" {
#   ami           = "unknown"
#   instance_type = "unknown"
#    }
