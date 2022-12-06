// Since GCP HA VPN provided 2 Network Interfaces, we will gate 1 AWS Customer Gateway for each Interface.
// The names of the Customer Gateways will be Alpha & Beta
// bgp_asn should be the same one set in the gcp-cloud-router.tf

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
