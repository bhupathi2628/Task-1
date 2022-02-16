
#Module      : EC2 webserver
#Description : Terraform module to create an EC2 resource on AWS.

module "aws_ec2_web_server" {
  source = "github.com/bhupathi2628/Task-1.git//modules/ec2?ref=master"

  name                        = var.name
  ami                         = var.instance_id
  instance_count              = 1
  instance_type               = var.instance_type
  key_name                    = var.key_name
  vpc_security_group_ids      = [module.mi-sg.security_group_id]
  subnet_id                   = var.public_subnet_ids
  associate_public_ip_address = true

  root_block_device = [
    {
      volume_type           = "gp2"
      volume_size           = 16
      delete_on_termination = true
    }
  ]

  tags = {
    name = "jenkinsserver"
  }
}
