variable "name" {
  description = "The type of instance to name"
  type        = string
  default     = "ec2-server" 
}

variable "instance_id" {
  description = "The type of instance id that used to lunch instance"
  type        = string
  default     = "ami-038b3df3312ddf25d"
}

variable "instance_type" {
  description = "The type of instance to start"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "This is key name that used to login to the instance"
  type        = string
  default     = "jenkinsserverkey" 
}

 variable "public_subnet_ids" {
  description = "This is subnet that used to lunch instance"
  type = string
  default = "subnet-07e7e3dfded0d3b61"
}
  
# variable "vpc_id" {
#   description = "This is vpc where we lunch instance"
#   type = string
#   default ="vpc-0fb1f05fbe81f2e2a"
# }



