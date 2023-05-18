#!/usr/bin/bash

sed -i 's/v1.24.1/v1.25.4/g' variables.tf
terraform apply --target=module.oci-oke.oci_containerengine_cluster.oci_oke_cluster --auto-approve

sed -i 's/v1.24.1/v1.25.4/g' terraform.tfvars
sed -i 's/ocid1.image.oc1.phx.aaaaaaaafhnymeqt5q3437wiuckekjodt3funyfz6hxuanchpfoqzq6nhxrq/ocid1.image.oc1.phx.aaaaaaaas3s5ziwx2mvrrz6juwzqfck7u4m2sfgsiijp6qxh6ni4vasu5peq/g' terraform.tfvars

grep -n node_pool_size terraform.tfvars | grep -v ":#" > tmp
while read -r line;
do
        echo "$line"
        lineno=$(echo "$line" | cut -d ":" -f 1)
        nodepoosize=$(echo "$line" | awk -F"= " '{ print $2 }' | tr -d ',')
        sed -i "${lineno}s/${nodepoosize}/2/g" terraform.tfvars
done < tmp
terraform apply --auto-approve
mv inplace.bk inplace.tf
terraform apply --auto-approve
