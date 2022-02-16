# variable "node_type" {
#   description = "This is node type that used to lunch redis instance in aws"
#   type        = string
#   default     = "cache.t3.micro"
# }

# variable "subnets" {
#   description = "These are the subnets used to created redis instance in aws"
#   type        = list(string)
#   default     = ["subnet-07a9f95f2e48a963c", "subnet-07afdee673da7ebe7", "subnet-03c63a11c87be9ebd"]
# }

# variable "vpc_id" {
#   description = "This is vpc where we lunch instance"
#   type        = string
#   default     = "vpc-0fb1f05fbe81f2e2a"
# }