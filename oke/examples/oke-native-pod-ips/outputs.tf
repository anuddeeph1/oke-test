## Copyright (c) 2022 Oracle and/or its affiliates.
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

output "KubeConfig" {
  value = module.oci-oke.KubeConfig
}

output "Cluster" {
  value = module.oci-oke.cluster
}
output "NodePool1" {
  value = module.oci-oke.node_pool1[*]
}
output "NodePool2" {
  value = module.oci-oke.node_pool2[*]
}
output "NodePool3" {
  value = module.oci-oke.node_pool3[*]
}
