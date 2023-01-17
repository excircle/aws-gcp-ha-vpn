resource "aws_subnet" "main_subnet" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "10.2.2.0/28"
  availability_zone = "us-west-2a"
  tags = {
    Name     = "akalaj-HAVPN-Demo-Subnet"
    CreateBy = "Terraform"
    Owner    = "Alexander Kalaj"
    Team     = "ISE"
  }
}
