/*
aws ec2 create-vpn-connection \
    --type ipsec.1 \
    --customer-gateway-id CUSTOMER_GATEWAY_1 \
    --transit-gateway-id TRANSIT_GATEWAY_ID \
    --options TunnelOptions='[{TunnelInsideCidr=AWS_T1_IP,PreSharedKey=SHARED_SECRET_1},{TunnelInsideCidr=AWS_T2_IP,PreSharedKey=SHARED_SECRET_2}]'

aws ec2 create-vpn-connection \
    --type ipsec.1 \
    --customer-gateway-id CUSTOMER_GATEWAY_2 \
    --transit-gateway-id TRANSIT_GATEWAY_ID \
    --options TunnelOptions='[{TunnelInsideCidr=AWS_T3_IP,PreSharedKey=SHARED_SECRET_3},{TunnelInsideCidr=AWS_T4_IP,PreSharedKey=SHARED_SECRET_4}]'

Replace the following:

CUSTOMER_GATEWAY_1: Google Cloud VPN gateway, interface 0
CUSTOMER_GATEWAY_2: Google Cloud VPN gateway, interface 1
AWS_T1_IP: Inside IP address for virtual private gateway for connection 1, tunnel 1
AWS_T2_IP: Inside IP address for virtual private gateway for connection 1, tunnel 2
AWS_T3_IP: Inside IP address for virtual private gateway for connection 2, tunnel 1
AWS_T4_IP: Inside IP address for virtual private gateway for connection 2, tunnel 2
SHARED_SECRET_1: Pre-shared key for connection 1, tunnel 1
SHARED_SECRET_2: Pre-shared key for connection 1, tunnel 2
SHARED_SECRET_3: Pre-shared key for connection 2, tunnel 1
SHARED_SECRET_4: Pre-shared key for connection 2, tunnel 2

AWS reserves some CIDR ranges, so you can't use values in these ranges as inside IP addresses
(AWS_T1_IP, AWS_T2_IP, AWS_T3_IP, AWS_T4_IP).
For information about what CIDR blocks AWS reserves, see Inside tunnel IPv4 CIDR.

*/

// Borrowed from Spotify (https://github.com/spotify/terraform-google-aws-hybrid-cloud-vpn/blob/master/variables.tf)
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
  transit_gateway_id                   = aws_ec2_transit_gateway.aws_to_gcp_tgw.id
  type                                 = aws_customer_gateway.cgw-alpha.type # "ipsec.1"
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
  transit_gateway_id                   = aws_ec2_transit_gateway.aws_to_gcp_tgw.id
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
