resource "aws_customer_gateway" "cgw-alpha" {
  bgp_asn    = 65534
  ip_address = google_compute_ha_vpn_gateway.gateway.vpn_interfaces[0].ip_address
  type       = "ipsec.1"

  tags = {
    Name     = "aws-to-google-vpn-gateway-alpha"
    CreateBy = "Terraform"
    Owner    = "Alexander Kalaj"
    Team     = "ISE"
  }
}

resource "aws_customer_gateway" "cgw-beta" {
  bgp_asn    = 65534
  ip_address = google_compute_ha_vpn_gateway.gateway.vpn_interfaces[1].ip_address
  type       = "ipsec.1"

  tags = {
    Name     = "aws-to-google-vpn-gateway-beta"
    CreateBy = "Terraform"
    Owner    = "Alexander Kalaj"
    Team     = "ISE"
  }
}
