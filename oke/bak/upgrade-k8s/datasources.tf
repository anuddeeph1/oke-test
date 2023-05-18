data "oci_identity_tenancy" "tenancy" {
  tenancy_id = var.tenancy_ocid
}

data "oci_containerengine_node_pools" "all_node_pools" {
  compartment_id = var.compartment_ocid
  cluster_id     = var.cluster_id
}

data "oci_containerengine_node_pool_option" "node_pool_options" {
  node_pool_option_id = var.cluster_id
}
