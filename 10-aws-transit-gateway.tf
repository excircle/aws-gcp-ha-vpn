/*
aws ec2 create-transit-gateway --description TRANSIT_GATEWAY_DESCRIPTION \
    --options=AmazonSideAsn=65001,
    AutoAcceptSharedAttachments=enable, - 
    DefaultRouteTableAssociation=enable,
    DefaultRouteTablePropagation=enable,
    VpnEcmpSupport=enable,
    DnsSupport=enable
*/

resource "aws_ec2_transit_gateway" "aws_to_gcp_tgw" {
  amazon_side_asn                 = 65001
  auto_accept_shared_attachments  = "enable" # Whether resource attachment requests are automatically accepted
  default_route_table_association = "enable" # Whether resource attachments are automatically associated with the default association route table
  default_route_table_propagation = "enable" # Whether resource attachments automatically propagate routes to the default propagation route table.enable
  vpn_ecmp_support                = "enable" # Whether Equal-cost multipath (ECMP), a network routing strategy that allows traffic with the same source and destination—to be transmitted across multiple paths of equal cost
  dns_support                     = "enable" # Whether we support DNS hostnames
  tags = {
    Name     = "akalaj-HAVPN-Demo-transit-gatway"
    CreateBy = "Terraform"
    Owner    = "Alexander Kalaj"
    Team     = "ISE"
  }
}

/*
aws ec2 create-transit-gateway-vpc-attachment \
    --transit-gateway-id TRANSIT_GATEWAY_ID \
    --vpc-id VPC_ID \
    --subnet-id SUBNET_ID
*/

// Attach Transit GW => AWS Customer VPC

resource "aws_ec2_transit_gateway_vpc_attachment" "aws_cust_vpc_trans_attachment" {
  subnet_ids         = [aws_subnet.main_subnet.id]
  transit_gateway_id = aws_ec2_transit_gateway.aws_to_gcp_tgw.id
  vpc_id             = aws_vpc.main_vpc.id
  tags = {
    Name     = "akalaj-HAVPN-Demo-TGW-Attach"
    CreateBy = "Terraform"
    Owner    = "Alexander Kalaj"
    Team     = "ISE"
  }
}
