# OKE Inplace Upgrade Using Terraform (Note: This Code is tested with 3 NodePools)

## Steps to upgrade OKE Cluster to v1.25.4
## METHOD-1
## Manual 
1. Open Variables.tf file and change variable of k8s_version to v1.25.4
```
variable "k8s_version" {
  #default = "v1.24.1"
  default = "v1.25.4"
}
```
2. Use Target deploy in terraform to upgrade OKE Controlplane.
```
terraform apply --target=module.oci-oke.oci_containerengine_cluster.oci_oke_cluster
```
3. change the nodepool k8s version(np_k8s_version) to v1.25.4, node_image_id to ocid1.image.oc1.phx.aaaaaaaas3s5ziwx2mvrrz6juwzqfck7u4m2sfgsiijp6qxh6ni4vasu5peq and double the node_pool_size (ex: if node_pool_size is 2, then increase node_pool_size to 4)
```
node_pools = {
  # Basic node pool
  np1 = {
    np_k8s_version          = "v1.25.4"
    node_image_id           = "ocid1.image.oc1.phx.aaaaaaaas3s5ziwx2mvrrz6juwzqfck7u4m2sfgsiijp6qxh6ni4vasu5peq"
    #np_k8s_version          = "v1.24.1"
    #node_image_id           = "ocid1.image.oc1.phx.aaaaaaaafhnymeqt5q3437wiuckekjodt3funyfz6hxuanchpfoqzq6nhxrq"
    shape                   = "VM.Standard.E4.Flex",
    ocpus                   = 3,
    memory                  = 5,
    node_pool_size          = 2,
    #node_pool_size.         = 1,
    boot_volume_size        = 150,
    eviction_grace_duration = 0, //Grade duration in minutes. Service default is 60.
    force_node_delete       = true
  }
  # node pool with initial node labels
  np2 = {
    np_k8s_version          = "v1.25.4"
    node_image_id           = "ocid1.image.oc1.phx.aaaaaaaas3s5ziwx2mvrrz6juwzqfck7u4m2sfgsiijp6qxh6ni4vasu5peq"
    #np_k8s_version          = "v1.24.1"
    #node_image_id           = "ocid1.image.oc1.phx.aaaaaaaafhnymeqt5q3437wiuckekjodt3funyfz6hxuanchpfoqzq6nhxrq"
    shape                   = "VM.Standard.E4.Flex",
    ocpus                   = 3,
    memory                  = 5,
    node_pool_size          = 2,
    #node_pool_size.         = 1,
    boot_volume_size        = 150,
    label                   = { app = "frontend", pool = "np2" },
  }
  # node pool with freeform tags
  np3 = {
    np_k8s_version          = "v1.25.4"
    node_image_id           = "ocid1.image.oc1.phx.aaaaaaaas3s5ziwx2mvrrz6juwzqfck7u4m2sfgsiijp6qxh6ni4vasu5peq"
    #np_k8s_version          = "v1.24.1"
    #node_image_id           = "ocid1.image.oc1.phx.aaaaaaaafhnymeqt5q3437wiuckekjodt3funyfz6hxuanchpfoqzq6nhxrq"
    shape                   = "VM.Standard.E4.Flex",
    ocpus                   = 3,
    memory                  = 5,
    node_pool_size          = 2,
    #node_pool_size.         = 1,
    boot_volume_size        = 150,
    nodepool_freeform_tags  = { app = "frontend", pool = "np3" },
    node_freeform_tags      = { app = "frontend", nodes = "np3" },
  }
}
```
4. Run the below command to create upgrade nodepools to v1.25.4 k8s version.
```
terraform apply --auto-approve
```
5. The inplace.bk file will run the script to drain and delete v1.24.1 k8s version nodes 
```
resource "null_resource" "inplace_upgrade" {
  provisioner "local-exec" {
    command = "/root/anudeep/inplace-upgrade-test/test-2/oke/examples/oke-native-pod-ips/inplace.sh"
  }
  depends_on = [
    module.oci-oke.cluster,
    module.oci-oke.node_pool,
  ]
}
```
6. Rename the inplace.bk to inplace.tf
```
mv inplace.bk inplace.tf
```
7. Run the below command to drain and delete v1.24.1 k8s version nodes 
```
terraform apply --auto-approve
```

## METHOD-2
## Script
1. script will perform all the steps present in Manual Method to perform inplace upgrade
```
cat terraform_inplace_upgrade.sh
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
```
2. Run the script
```
./terraform_inplace_upgrade.sh
```
