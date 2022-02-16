
#Module      : EC2 webserver
#Description : Terraform module to create an EC2 resource on AWS.

module "aws_ec2_web_server" {
  source = "../../modules/ec2"
  name                        = "jenkins_server"
  ami                         = "ami-038b3df3312ddf25d" 
  instance_count              = 1
  instance_type               = "t2.micro"
  key_name                    = "jenkinsserverkey"
  vpc_security_group_ids      = [module.mi-sg.security_group_id]
  subnet_id                   = "subnet-07a9f95f2e48a963c"
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
