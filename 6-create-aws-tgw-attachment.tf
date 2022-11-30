resource "aws_ec2_transit_gateway_vpc_attachment" "vault_tgw" {
  subnet_ids         = [aws_subnet.main_subnet.id]
  transit_gateway_id = aws_ec2_transit_gateway.vault_tgw.id
  vpc_id             = aws_vpc.main_vpc.id
  tags = {
    Name     = "akalaj-Oanda-Demo-TGW-Attach"
    CreateBy = "Terraform"
    Owner    = "Alexander Kalaj"
    Team     = "ISE"
  }
}
