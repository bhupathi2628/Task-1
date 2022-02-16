resource "aws_key_pair" "my-key" {
  count = var.create_key_pair ? 1 : 0
  key_name   = var.key_name
  public_key = var.public_key
}
