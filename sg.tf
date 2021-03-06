module "mi-sg" {
  source      = "github.com/bhupathi2628/Task-1.git//modules/security_group?ref=master"
  name        = "security-group"
  description = "security-group"
  vpc_id      = module.aws_vpc.aws_vpc_id

  # Ingress rules #
  ingress_with_self = [
    {
      description = "this is self security group"
      from_port   = "0"
      to_port     = "0"
      protocol    = "-1"
    }
  ]

  ingress_with_cidr_blocks = [
    {
      description = "ssh"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      description = "All"
      from_port   = 0
      to_port     = 0
      protocol    = -1
      cidr_blocks = ["0.0.0.0/0"]
    },
  ]

  # Egress rules #
  egress_with_cidr_blocks = [
    {
      from_port   = "0"
      to_port     = "0"
      protocol    = "-1"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
}