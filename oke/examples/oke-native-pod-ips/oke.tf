## Copyright (c) 2022 Oracle and/or its affiliates.
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

module "oci-oke" {
  #source                              = "github.com/oracle-devrel/terraform-oci-arch-oke"
  source           = "../../"
  tenancy_ocid     = var.tenancy_ocid
  compartment_ocid = var.compartment_ocid
  oke_cluster_name = var.oke_cluster_name
  k8s_version      = var.k8s_version
  ssh_public_key   = var.ssh_public_key
  label_prefix     = var.label_prefix
  #pool_name                           = var.pool_name
  node_pools                           = var.node_pools
  node_shape                           = var.node_shape
  node_ocpus                           = var.node_ocpus
  node_memory                          = var.node_memory
  node_count                           = var.node_count
  node_linux_version                   = var.node_linux_version
  use_existing_vcn                     = true
  vcn_id                               = var.vcn_ocid
  is_api_endpoint_subnet_public        = false
  api_endpoint_subnet_id               = var.my_api_endpoint_subnet_ocid
  kms_key_id                           = var.kms_key_id
  nodepool_subnet_id                   = var.my_pods_nodepool_subnet_ocid
  oci_vcn_ip_native                    = true
  max_pods_per_node                    = 50
  pods_subnet_id                       = var.pods_subnet_ocid
  node_eviction_node_pool_settings     = true
  eviction_grace_duration              = "PT0M"
  is_force_delete_after_grace_duration = true
  # freeform-tags
  cluster_name_key   = var.cluster_name_key
  cluster_name_value = var.cluster_name_value
  cluster_role_key   = var.cluster_role_key
  cluster_role_value = var.cluster_role_value
  cluster_env_key    = var.cluster_env_key
  cluster_env_value  = var.cluster_env_value

}

#freeform_tags_cluster = var.freeform_tags_cluster
#defined_tags_cluster  = var.defined_tags_cluster
#freeform_tags_nodepool = var.freeform_tags_nodepool
#defined_tags_nodepool  = var.defined_tags_nodepool
#service_subnet_id                    = var.service_subnet_ocid
#pods_cidr                     = var.pods_cidr
#services_cidr                 = var.services_cidr
#is_lb_subnet_public                  = false
# lb_subnet_id                         = var.my_lb_subnet_ocid
