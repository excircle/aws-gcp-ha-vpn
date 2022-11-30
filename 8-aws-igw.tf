resource "aws_internet_gateway" "vpc_igw" {
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    Name     = "akalaj-Oanda-Demo-IGW"
    CreateBy = "Terraform"
    Owner    = "Alexander Kalaj"
    Team     = "ISE"
  }
}
