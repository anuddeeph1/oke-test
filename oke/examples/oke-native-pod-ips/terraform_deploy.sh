#!/bin/bash

#function to handle interrupt signal
interrupt_handler() {
echo "Script interrupted by user."
exit 1
}

#trap interrupt signal
trap interrupt_handler SIGINT

#initialize Terraform
terraform init

#execute Terraform plan for specific target
terraform plan -target nirmata_cluster_registered.oke-registered

#apply Terraform changes for specific target and auto-approve
terraform apply -target nirmata_cluster_registered.oke-registered --auto-approve

#execute Terraform plan
terraform plan

#apply all Terraform changes and auto-approve
terraform apply --auto-approve
terraform apply -target module.oci-oke.local_file.OKEKubeConfigFile --auto-approve
#check if exit status is not 0, retry Terraform apply
while [ $? -ne 0 ]
do
echo "Terraform apply failed. Retrying..."
sleep 5
terraform apply -target module.oci-oke.local_file.OKEKubeConfigFile --auto-approve
terraform destroy -target nirmata_cluster_registered.oke-registered --auto-approve
terraform apply -target nirmata_cluster_registered.oke-registered --auto-approve
terraform apply --auto-approve
done
echo "Terraform apply successful."
