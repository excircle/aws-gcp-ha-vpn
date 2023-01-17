# HA VPN Networking for HCP Vault

This document is meant to accompany the Github Repo `aws-gcp-ha-vpn`.

This repository contains Terraform files which are numbered in an effort to roughly convey the order and sequence of cloud objects that must be created in order for the HA VPN to exist.

# Foundational Knowledge

There are two documents which explain the process of creating an HA VPN

[Google Cloud Platform Docs](https://cloud.google.com/architecture/build-ha-vpn-connections-google-cloud-aws)

[HashiCorp Developer HCP Docs](https://developer.hashicorp.com/hcp/tutorials/networking/gcp-connect-hcp?in=cloud%2Fnetworking)

Of the two, the GCP is more descriptive in detailing what needs to be done for GCP resources, but both ultimately fail to deliver a connect which works by simply following all instructions.

The below steps will establish a network topology that closely resembles the diagram below:

![Google HA VPN Diagram](https://cloud.google.com/static/architecture/images/build-ha-vpn-connections-google-cloud-aws.svg)

# 1.) GCP VPC Creation

You'll need a VPC resource in Google Cloud to make the VPN work. Google Cloud Docs state that a VPC must be created with the following settings. Terraform file `1-gcp-vpc.tf` creates a GCP resource in this fashion.

```bash
gcloud compute networks create $VPC_NAME \
    --subnet-mode custom \
    --bgp-routing-mode global
```

`--subnet-mode=custom` Allows users to create subnets manually.

`--bgp-routing-mode=GLOBAL` Allows Cloud Routers in this network advertise subnetworks from all regions to their BGP peers, and program instances in all regions with the router's best learned BGP routes.

# 2.) Create A Private GCP Subnetwork

This will be the target subnet to communicate with from GCP Vault

# 3.) Create GCP HA VPN Gateway

Both the GCP and HCP Docs advise that the HA VPN will create 2 network interfaces.

Each of the (2) interfaces will create an IP Address, and those IP Addresses will be handled via the Terraform code in this repository. The GCloud command that is provided by Google is listed below

```bash
gcloud compute vpn-gateways create $HA_VPN_GATEWAY_NAME \
    --network $NETWORK \
    --region $REGION
```

# 4.) Create GCP Cloud Router

GCP Cloud Router enables you to dynamically exchange routes between your VPC and peer network by using Border Gateway Protocol (BGP).

GCP Docs call for a Router to be created with the following settings.

```bash
gcloud compute routers create cloud-router \
    --region us-east4 \
    --network $VPC_NAME \
    --asn 65534 \
    --advertisement-mode custom \
    --set-advertisement-groups all_subnets
```

`--advertisement-mode` Means the BGP session inherits the Cloud Router configuration. Custom routes configured on the whole Cloud Router are advertised as described in Custom route advertisement. Custom routes might contain some or all subnet routes.

`set-advertisement-groups` A Google-defined group that Cloud Router dynamically advertises

<b>NOTE: </b>Per the [GCloud Docs HERE]() the only valid value is `all_subnets`, which advertises subnets based on the VPC network's dynamic routing mode (similar to the default advertisements).

# 5.) Create AWS VPC

Since you cannot directly interact with the HCP HVNs, you'll need a "customer VPC" in AWS to facilitate communication to the HCP HVN.

Create a basic VPC.

# 6.) Create AWS Subnet

This will be the target subnet that we'll use to confirm access from GCP.

# VPN Gateway or Transit Gateway?

GCP Docs call for either a "VPN Gateway" or a "Transit Gateway" to make the HA VPN work.

<b>Virtual Private Gateway</b>: A virtual private gateway is the VPN endpoint on the Amazon side of your Site-to-Site VPN connection that can be attached to a single VPC.

<b>Transit Gateway</b>: A transit hub that can be used to interconnect multiple VPCs and on-premises networks, and as a VPN endpoint for the Amazon side of the Site-to-Site VPN connection.

Since we are connecting to "multiple VPCs," a transit gateway will be required. This is also echoed in the [HashiCorp Developer HCP Docs](https://developer.hashicorp.com/hcp/tutorials/networking/gcp-connect-hcp?in=cloud%2Fnetworking#create-aws-vpn)

# 7.) Create AWS Customer Gateway

Since there are redundant IP Addresses created for the GCP HA VPN Gateway created in Step 3, we will create a customer gateway for each.

GCP Docs advise the following settings for your HA VPN connection.

```bash
aws ec2 create-customer-gateway --type ipsec.1 --public-ip INTERFACE_0_IP_ADDRESS --bgp-asn GOOGLE_ASN
aws ec2 create-customer-gateway --type ipsec.1 --public-ip INTERFACE_1_IP_ADDRESS --bgp-asn GOOGLE_ASN
```

`7-aws-customer-gateway.tf` reflects this recommended configuration.

# 8->10 Create an Internet Gateway, Route Table, Transit Gateway

Since the next resources are dependant on each other, they should be created at the same time.

<b>Internet Gateway: </b>Allows communication between your VPC and the internet.
<b>Route Table: </b>Controls the routing for all subnets that are not explicitly associated with any other route table
<b>Transit Gateway: </b>A regional resource that can connect thousands of VPCs to a target VPC within the same region

The Transit Gateway will be used to bridge connections between GCP, AWS, and HCP HVNs. The diagram below illustrates this point.

![HCP Transit Diagram](https://content.hashicorp.com/api/assets?product=tutorials&version=main&asset=public%2Fimg%2Fcloud%2Fdiagram-hcp-aws-gcp-transit-network.png)

### Network Routing

We must have a default route table that provides routes to HCP and GCP within AWS. `9-aws-default-route-table.tf` specifies the following routes:

```golang
  // HCP HVN CIDR
  route {
    cidr_block         = "172.25.16.0/24"
    transit_gateway_id = aws_ec2_transit_gateway.aws_to_gcp_tgw.id
  }

  // Local VPC
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpc_igw.id
  }

  // GCP CIDR
  route {
    cidr_block = "10.1.1.0/24"
    gateway_id = aws_ec2_transit_gateway.aws_to_gcp_tgw.id
  }
```

`10-aws-transit-gateway.tf` Also handles the attachment of the Transit Gateway to our "Customer" AWS VPC.

# 11.) Create a VPN connection

An AWS VPN connection as defined by AWS.

<b>VPN connection</b>: A secure connection between your on-premises equipment and your VPCs.
<b>VPN tunnel</b>: An encrypted link where data can pass from the customer network to or from AWS.

This step creates 4 IPs that will later be utilized to establish connections between GCP and AWS.

# 12.) Create GCP External VPN Connection

Bind AWS VPN IPs to GCP Interfaces created in Step 3

# 13.) Establish Tunnels Using Connections From Step 12

`13-gcp-vpn-tunnels.tf` tells GCP to establish tunnels through the VPN using connections created in step 12.

# 14.) Associate GCP Cloud Router To Tunnels

`14-gcp-router-interfaces.tf` binds tunnels to GCP Cloud Router.

# 15.) Add AWS VPC As Trusted Peer

`15-gcp-bgp-route-peers.tf` Add "Customer" VPC as trusted Peer.

# 16->17 Create HCP HVN + Vault Cluster

`16-hcp-hvn.tf` + `17-hcp-vault-cluster.tf` create a HashiCorp Virtual Network and a Vault Cluster.

# 18.) Create AWS Resorce Access Manager

<b>AWS Resource Access Manager: </b>Construct which allows AWS resources (Customer VPC) to become usable by other AWS accounts (Customer HVN).

`18-hcp-ram.tf` does the following RAM related processes:

- Creates RAM resource in "Customer" VPC account
- Associates RAM with HCP HVN ID
- Associates RAM with "Customer" Transit Gateway

# 19.) Tell HCP To Trust/Attach AWS Transit Gateway

`19-hcp-transit-attach.tf` attaches HCP to the AWS Transit Gateway

# 20.) Register AWS & GCP Routes Into HVN

Add applicable routes in AWS and/or GCP to allow traffic from HVN to return to clients residing in either cloud.
