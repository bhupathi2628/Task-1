 module "keypair" {
  source = "../../modules/key_pair"
  key_name        = "jenkinsserverkey"
  public_key      = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCnsx6DjpkFV7yin/yXs4Am+0KK/juK4t1hQAuCq6hpx40i7lTiFDzzuPs4WPd9xctYxR8G7dmcvU/P4wUL6yfbrOmhGNeqJRZsozWhjPyOtzYJfIrAr4VarNtr2eeQDEV757mXqxr3paTUsYIkxzAu3CTuIZsLpjpYB8XNgRzx9pS+MnPKvR6rt2Da48+gTXJCr02tZea4omQ63ss2tscz5Fqhl0eh9bCLjE8zYBcmaLjeV8/b4sKRvek3oOBNVJQZ85of6wq7gMDxEdLh795J47LUYoUd/4VwAK3cH9jjQ+N0RmSQuYctkhp5hTpCIGCEfGyH1YJIuhPyPhg3vVo/ rsa-key-20220215"
} 