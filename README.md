# Example HA VPN Between GCP & AWS

The code kept in this repository is meant to demonstrate an HA VPN connection which becomes established between GCP and AWS respectively.

Once the VPN is established, we will connect a Google GKE cluster to AWS hosted instance of HashiCorp Vault.

A diagram showing this connection is dipicted below.

![Example Architecture](https://cloud.google.com/static/architecture/images/build-ha-vpn-connections-google-cloud-aws.svg)

# Required Credentials


**HCP Vault Credentials**

1. Login at https://portal.cloud.hashicorp.com/sign-in
2. Go to IAM
3. Go to Service Principals
4. Create a Service Principal with the Contributor Role
5. Click on the User
6. Click Create Service Principal Key
7. Add client id and client secret to terraform.tfvars OR [export them as environment variables](https://registry.terraform.io/providers/hashicorp/hcp/latest/docs/guides/auth#two-options-to-configure-the-provider)


**AWS Credentials**
- Export these credentials as environment variables or add them to the settings.tf file

**GCP Credentials**
- Set your provider with credentials 

```golang
provider "google" {
  credentials = file("./credentials.json")
  project = "hc-bpj83j6dd89wm7956dh2214so"
  region  = "us-central1"
  zone    = "us-central1-c"
}
```

<b>ALTERNATIVE:</b>

- Set the following environment variables

```bash
export GOOGLE_APPLICATION_CREDENTIALS=/Users/akalaj/.config/gcloud/akalaj-dev.json
export GOOGLE_PROJECT=hc-03657a2ab8c84213a402eb28bbb
```

# GCP Dependancies Part 1

The following files generate the base GCP infrastructure needed for VPN establishment

| File | Description |
| - | - |
| 1-gcp-vpc.tf | Creates GCP VPC to connect to HCP Vault |
| 2-gcp-subnets.tf | Creates GCP Public & Private subnets for bastion-host and app testing. |
| 3-gcp-ha-vpn-gateway.tf | Creates HA VPN Gateway and 2 HA VPN Interfaces. This interfaces will have 2 IP Address that you'll need to add to the AWS Customer Gateway |
| 4-gcp-cloud-router.tf | GCP Cloud Router which will advertise GCP Subnets |
| 5-aws-vpc.tf | AWS VPC created by customer |
| 6-aws-subnet.tf | AWS Subnet for bastion host |
| 7-aws-customer-gateway.tf | AWS Customer Gateway Pointing to GCP HA VPN Interfaces created in `3-gcp-ha-vpn-gateway.tf` |
| 8-aws-internet-gateway.tf | AWS IGW leading to the outside internet |
| 9-aws-default-route-table.tf | TF File for altering AWS VPC's default route table
| 10-aws-transit-gateway.tf | AWS Transit Gateway for exporting connections
| 11-aws-vpn-connection.tf | VPN Connection with dynamic routing |


# AWS Dependancies Part 1

| File | Description |
| - | - |
| 5-aws-vpc.tf | VPC created by customer |
| 6-aws-subnet.tf | Subnet for Bastion Host |
| 7-aws-customer-gateway.tf | AWS customer gateways which point to the 2 GCP HA VPN Interfaces created in `3-gcp-ha-vpn-gateway.tf`. |
| 8-aws-internet-gateway.tf | Internet Gateway For Bastion Host |
| 8-aws-default-route-table.tf | Configuration for default route table |
| 9-aws-transit-gateway.tf | Transit Gateway for AWS Account

# GCP Dependancies Part 2

The following files generate the base GCP infrastructure needed for VPN establishment

| File | Description |
| - | - |

# HashiCorp Cloud Platform Dependancies

| File | Description |
| - | - |
| 1-create-hvn.tf | Creates the target HVN network |
| 2-create-vault-cluster.tf | Creates Vault |


# AWS Dependancies Part 2

| File | Description |
| - | - |
| 13-aws-cgw.tf | Creates 2 AWS customer gateways. 1 GW for each of the 2 IP Addresses for GCP VPN |