resource "google_compute_external_vpn_gateway" "external_gateway" {
  provider        = google-beta
  name            = "aws-${aws_ec2_transit_gateway.vault_tgw.id}-${data.aws_region.current.name}-akalaj"
  redundancy_type = "FOUR_IPS_REDUNDANCY"
  description     = "AWS Transit GW: ${aws_ec2_transit_gateway.vault_tgw.id} in AWS region ${data.aws_region.current.name}"

  dynamic "interface" {
    for_each = local.external_vpn_gateway_interfaces
    content {
      id         = interface.key
      ip_address = interface.value["tunnel_address"]
    }
  }
}
