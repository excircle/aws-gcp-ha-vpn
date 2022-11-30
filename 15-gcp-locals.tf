locals {
  ha_vpn_interfaces_ips = [
    for x in google_compute_ha_vpn_gateway.gateway.vpn_interfaces :
    lookup(x, "ip_address")
  ]
  external_vpn_gateway_interfaces = {
    "0" = {
      tunnel_address        = aws_vpn_connection.vpn-alpha.tunnel1_address
      vgw_inside_address    = aws_vpn_connection.vpn-alpha.tunnel1_vgw_inside_address
      asn                   = aws_vpn_connection.vpn-alpha.tunnel1_bgp_asn
      cgw_inside_address    = "${aws_vpn_connection.vpn-alpha.tunnel1_cgw_inside_address}/30"
      shared_secret         = aws_vpn_connection.vpn-alpha.tunnel1_preshared_key
      vpn_gateway_interface = 0
    },
    "1" = {
      tunnel_address        = aws_vpn_connection.vpn-alpha.tunnel2_address
      vgw_inside_address    = aws_vpn_connection.vpn-alpha.tunnel2_vgw_inside_address
      asn                   = aws_vpn_connection.vpn-alpha.tunnel2_bgp_asn
      cgw_inside_address    = "${aws_vpn_connection.vpn-alpha.tunnel2_cgw_inside_address}/30"
      shared_secret         = aws_vpn_connection.vpn-alpha.tunnel2_preshared_key
      vpn_gateway_interface = 0
    },
    "2" = {
      tunnel_address        = aws_vpn_connection.vpn-beta.tunnel1_address
      vgw_inside_address    = aws_vpn_connection.vpn-beta.tunnel1_vgw_inside_address
      asn                   = aws_vpn_connection.vpn-beta.tunnel1_bgp_asn
      cgw_inside_address    = "${aws_vpn_connection.vpn-beta.tunnel1_cgw_inside_address}/30"
      shared_secret         = aws_vpn_connection.vpn-beta.tunnel1_preshared_key
      vpn_gateway_interface = 1
    },
    "3" = {
      tunnel_address        = aws_vpn_connection.vpn-beta.tunnel2_address
      vgw_inside_address    = aws_vpn_connection.vpn-beta.tunnel2_vgw_inside_address
      asn                   = aws_vpn_connection.vpn-beta.tunnel2_bgp_asn
      cgw_inside_address    = "${aws_vpn_connection.vpn-beta.tunnel2_cgw_inside_address}/30"
      shared_secret         = aws_vpn_connection.vpn-beta.tunnel2_preshared_key
      vpn_gateway_interface = 1
    },
  }
}
