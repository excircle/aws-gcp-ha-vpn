resource "aws_vpc" "main_vpc" {
  cidr_block           = "10.2.2.0/24"
  enable_dns_hostnames = true
  tags = {
    Name     = "akalaj-Oanda-Demo-VPC"
    CreateBy = "Terraform"
    Owner    = "Alexander Kalaj"
    Team     = "ISE"
  }
}
