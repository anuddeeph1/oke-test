# terraform-oci-oke

This repository consistes of TF files needed for creating an oracle OKE cluster and then registering it in Nirmata. The cluster is created using the terraform-oci-oke module and the cluster is registered in Nirmata using the nirmata provider. More information about oracle oke terraform provider can be found [here](https://registry.terraform.io/modules/oracle-terraform-modules/oke/oci/latest). All the OKE related terraform configurations can be found [here](https://github.com/oracle-terraform-modules/terraform-oci-oke/blob/main/docs/terraformoptions.adoc). The details of Nirmata provider can be found [here](https://registry.terraform.io/providers/nirmata/nirmata/latest)

## Prerequisites
1. Download and install Terraform (v1.0 or later)
2. Download and install the OCI Terraform Provider (v4.4.0 or later)
3. Export OCI credentials. (this refer to the https://github.com/oracle/terraform-provider-oci )
4. VCN, subnets (api_endpoint_subnet,pods_nodepool_subnet,pods_cidr_subnet), route tables, NAT gateway, Internet Gateway, Service Gateway, DHCP Options and Security Lists
5. Policies setup in Oracle account to create an OKE cluster
6. Cluster type with all the required add-ons. This is needed for the nirmata provider in nirmata.tf
7. Access to nirmata.io and Nirmata API token

## Instructions to create cluster type in Nirmata: 
- Login to nirmata.io and go to Cluster -> Cluster Types 
- Create a cluster type for Registered Clusters/Existing Cluster
- Input details as required and select oraclecloudservice as cloud provider and select all the addons that are needed. 
- Cluster-type name will be used in next steps during terraform script creation 

## How to get an API Key in Nirmata:
- Generate an API key if not done already
- Login to nirmata and navigate to Settings-> Profile
- Generate an API Key and keep it handy as it will be used in terraform template

## How it works

- Clone the Terraform code from the link https://github.com/nirmata/oke.git
- Change directory to `examples/oke-native-pod-ips`.
- Update the values in the `terraform.tfvars` file as per your environment
- Execute the script below which runs the terraform commands. 

NOTE: The nirmata provider does not work when this is run on a windows machine. So currently this ONLY works on Mac and Linux machines

```
[root@saas oke-native-pod-ips]# ./terraform_deploy.sh
```
Once everything is completed, you should see a successful message like below. You can also verify this by logging in to Nirmata and verify that the cluster is registered 

```
Terraform apply successful
```
