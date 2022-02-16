#Module      : aws Vpc module
#Description : Terraform module to create an VPC resource on AWS.


module "aws_vpc" {
  source = "github.com/bhupathi2628/Task-1.git//modules/vpc?ref=master"

  name           = var.name
  vpc_cidr_block = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_dns_hostnames = true

  tags = {
    name = "demo-vpc"
  }
}






























/*module "mi-vpc" {
  source                           = "../../modules/vpc"
  dhcp_options_domain_name         = "test.euc1.aws.ti"
  enable_dns_hostnames             = true
  dhcp_options_domain_name_servers = ["AmazonProvidedDNS"]
  name                             = "testing"
  cidr                             = "10.111.28.0/22"
  public_subnets                   = ["10.111.28.0/24", "10.111.29.0/25", "10.111.29.128/26"]
  private_subnets                  = ["10.111.30.0/24", "10.111.31.0/25", "10.111.31.128/26"]
  enable_nat_gateway               = true
  single_nat_gateway               = true
  stage                            = var.stage
  enable_s3_endpoint               = true
  azs                              = var.azs
}*/