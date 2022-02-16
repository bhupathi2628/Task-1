variable "instance_type" {
  description = "The type of instance to start"
  type        = string
  default     = "t2.micro"
}


/* variable "public_subnet" {
  type = list(string)
  default = ["subnet-07a9f95f2e48a963c", "subnet-07afdee673da7ebe7","subnet-03c63a11c87be9ebd"]
}
variable "private_subnet" {
  type = list(string)
  default = ["subnet-066992d3087a95c74", "subnet-09c3e89eb5b4f065b" ,  "subnet-084217ef470454a98"]
} */

variable "instance_id" {
  default = "i-062b5322226eb1b86"
}

variable "vpc_id" {
  default ="vpc-0113a3f75ad27276e"
}

variable "security_group_id" {
  default = "sg-073b8c4d281718a53" 
}

# variable "public_subnet_ids" {}
  
# variable "private_subnet_ids" {}

#publicsubents: "subnet-07a9f95f2e48a963c", "subnet-07afdee673da7ebe7","subnet-03c63a11c87be9ebd"
#privatesubnets: "subnet-066992d3087a95c74", "subnet-09c3e89eb5b4f065b" ,  "subnet-084217ef470454a98"













# #### GLOBAL VARS #####

# variable "public-subnet-1a" {}
# variable "public-subnet-1b" {}
# variable "public-subnet-1c" {}
# variable "private-subnet-1a" {}
# variable "private-subnet-1b" {}
# variable "private-subnet-1c" {}
# variable "ami-centos-7" {}
# variable "prefix" {}
# variable "stage" {}
# variable "phase" {}
# variable "az1a" {}
# variable "az1b" {}
# variable "az1c" {}
# variable "magmt-subnets" {}
# variable "hosted-zone-name" {}
# variable "aws-vpc-id" {}
# variable "mi-global-dns-forward-zone-id" {}
# variable "mi-global-dns-external-zone-id" {}
# variable "public-subnets" {}
# variable "private-subnets" {}

# ##### LOCAL VARS #####

# variable "cluster-long-name" {}
# variable "cluster-short-name" {}

