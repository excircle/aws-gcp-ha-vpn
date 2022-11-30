variable "aws_vpn_configs" {
  type        = map(any)
  description = "AWS Tunnels Configs for aws_vpn_connection. This addresses this [known issue](https://cloud.google.com/network-connectivity/docs/vpn/how-to/creating-ha-vpn)."
  default = {
    encryption_algorithms = ["AES256"]
    integrity_algorithms  = ["SHA2-256"]
    dh_group_numbers      = ["18"]
  }
}

resource "aws_vpn_connection" "vpn-alpha" {
  customer_gateway_id                  = aws_customer_gateway.cgw-alpha.id
  transit_gateway_id                   = aws_ec2_transit_gateway.vault_tgw.id
  type                                 = aws_customer_gateway.cgw-alpha.type
  tunnel1_phase1_encryption_algorithms = var.aws_vpn_configs.encryption_algorithms
  tunnel2_phase1_encryption_algorithms = var.aws_vpn_configs.encryption_algorithms
  tunnel1_phase1_integrity_algorithms  = var.aws_vpn_configs.integrity_algorithms
  tunnel2_phase1_integrity_algorithms  = var.aws_vpn_configs.integrity_algorithms
  tunnel1_phase1_dh_group_numbers      = var.aws_vpn_configs.dh_group_numbers
  tunnel2_phase1_dh_group_numbers      = var.aws_vpn_configs.dh_group_numbers
  tunnel1_phase2_encryption_algorithms = var.aws_vpn_configs.encryption_algorithms
  tunnel2_phase2_encryption_algorithms = var.aws_vpn_configs.encryption_algorithms
  tunnel1_phase2_integrity_algorithms  = var.aws_vpn_configs.integrity_algorithms
  tunnel2_phase2_integrity_algorithms  = var.aws_vpn_configs.integrity_algorithms
  tunnel1_phase2_dh_group_numbers      = var.aws_vpn_configs.dh_group_numbers
  tunnel2_phase2_dh_group_numbers      = var.aws_vpn_configs.dh_group_numbers

  tags = {
    Name     = "vpn-to-google-alpha-akalaj"
    CreateBy = "Terraform"
    Owner    = "Alexander Kalaj"
    Team     = "ISE"
  }
}

resource "aws_vpn_connection" "vpn-beta" {
  customer_gateway_id                  = aws_customer_gateway.cgw-beta.id
  transit_gateway_id                   = aws_ec2_transit_gateway.vault_tgw.id
  type                                 = aws_customer_gateway.cgw-beta.type
  tunnel1_phase1_encryption_algorithms = var.aws_vpn_configs.encryption_algorithms
  tunnel2_phase1_encryption_algorithms = var.aws_vpn_configs.encryption_algorithms
  tunnel1_phase1_integrity_algorithms  = var.aws_vpn_configs.integrity_algorithms
  tunnel2_phase1_integrity_algorithms  = var.aws_vpn_configs.integrity_algorithms
  tunnel1_phase1_dh_group_numbers      = var.aws_vpn_configs.dh_group_numbers
  tunnel2_phase1_dh_group_numbers      = var.aws_vpn_configs.dh_group_numbers
  tunnel1_phase2_encryption_algorithms = var.aws_vpn_configs.encryption_algorithms
  tunnel2_phase2_encryption_algorithms = var.aws_vpn_configs.encryption_algorithms
  tunnel1_phase2_integrity_algorithms  = var.aws_vpn_configs.integrity_algorithms
  tunnel2_phase2_integrity_algorithms  = var.aws_vpn_configs.integrity_algorithms
  tunnel1_phase2_dh_group_numbers      = var.aws_vpn_configs.dh_group_numbers
  tunnel2_phase2_dh_group_numbers      = var.aws_vpn_configs.dh_group_numbers

  tags = {
    Name     = "vpn-to-google-beta-akalaj"
    CreateBy = "Terraform"
    Owner    = "Alexander Kalaj"
    Team     = "ISE"
  }
}
