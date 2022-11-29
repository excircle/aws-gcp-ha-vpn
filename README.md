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
- Export your credentials to a file called `creds.json` or pass them in with a variable

# HashiCorp Cloud Platform Dependancies

| File | Description |
| - | - |
| 1-create-hvn.tf | Creates the target HVN network |