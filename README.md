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


# HashiCorp Cloud Platform Dependancies

| File | Description |
| - | - |
| 1-create-hvn.tf | Creates the target HVN network |
| 2-create-vault-cluster.tf | Creates Vault |

# AWS Dependancies Part 1

| File | Description |
| - | - |
| 3-create-aws-vpc.tf | Creates AWS VPC to connect to HCP Vault |
| 4-create-aws-subnet.tf | Creates AWS subnet |
| 5-create-aws-tgw.tf | Creates AWS Transit Gateway |
| 6-create-aws-tgw-attachment.tf | - |
| 7-aws-resource-access-manager.tf | - |
| 8-aws-igw.tf | - |
| 9-aws-route-table.tf | - |
| 10-aws-sec-group.tf | - |
| 11-aws-bastion.tf | - |



# AWS Dependancies Part 2

| File | Description |
| - | - |
| 13-aws-cgw.tf | Creates 2 AWS customer gateways. 1 GW for each of the 2 IP Addresses for GCP VPN |