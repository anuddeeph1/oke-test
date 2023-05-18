## Copyright (c) 2022 Oracle and/or its affiliates.
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

variable "kms_key_id" {}
variable "compartment_ocid" {
  default = ""
}

variable "tenancy_ocid" {
  default = ""
}
variable "label_prefix" {
  default     = "none"
  description = "A string that will be prepended to all resources."
  type        = string
}
variable "node_pools" {
  default     = {}
  description = "Tuple of node pools. Each key maps to a node pool. Each value is a tuple of shape (string),ocpus(number) , node_pool_size(number) and boot_volume_size(number)"
  type        = any
}
variable "availability_domain" {
  default = ""
}

variable "use_existing_vcn" {
  default = true
}

variable "use_existing_nsg" {
  default = true
}

variable "vcn_cidr" {
  default = "10.0.0.0/16"
}

variable "vcn_id" {
  default = ""
}

variable "nodepool_subnet_id" {
  default = ""
}

variable "nodepool_subnet_cidr" {
  default = "10.0.1.0/24"
}

variable "lb_subnet_id" {
  default = ""
}

variable "lb_subnet_cidr" {
  default = "10.0.2.0/24"
}

variable "api_endpoint_subnet_id" {
  default = ""
}

variable "api_endpoint_subnet_cidr" {
  default = "10.0.3.0/24"
}

variable "api_endpoint_nsg_ids" {
  default = []
}

variable "pods_subnet_id" {
  default = ""
}

variable "pods_nsg_ids" {
  default = []
}

variable "oke_cluster_name" {
  default = "OKE_Cluster"
}

variable "vcn_native" {
  default = true
}

variable "is_api_endpoint_subnet_public" {
  default = false
}

variable "is_lb_subnet_public" {
  default = false
}

variable "is_nodepool_subnet_public" {
  default = false
}

variable "k8s_version" {
  default = "v1.24.1"
}

variable "np_k8s_version" {
  default = "v1.24.1"
}
variable "pool_name" {
  default = "Demo_Node_Pool"
}

variable "node_shape" {
  default = "VM.Standard.E4.Flex"
}

variable "node_image_id" {
  default = "ocid1.image.oc1.phx.aaaaaaaamshmavyi6vipgnoppgjyns7ddnpqxwlbhosprfpaq3pxuq3f2woa"
}
variable "node_pool_boot_volume_size_in_gbs" {
  default = 50
}

variable "node_ocpus" {
  default = 2
}

variable "node_memory" {
  default = 4
}

variable "oci_vcn_ip_native" {
  default = false
}

variable "max_pods_per_node" {
  default = 10
}

variable "pods_cidr" {
  default = "10.1.0.0/16"
}

variable "services_cidr" {
  default = "10.2.0.0/16"
}

variable "pods_subnet_cidr" {
  default = "10.0.4.0/24"
}

variable "node_linux_version" {
  default = "7.9"
}

variable "node_count" {
  default = 1
}

variable "cluster_options_add_ons_is_kubernetes_dashboard_enabled" {
  default = true
}

variable "cluster_options_add_ons_is_tiller_enabled" {
  default = true
}

variable "cluster_options_admission_controller_options_is_pod_security_policy_enabled" {
  default = false
}

variable "node_pool_initial_node_labels_key" {
  default = "key"
}

variable "node_pool_initial_node_labels_value" {
  default = "value"
}

variable "cluster_kube_config_token_version" {
  default = "2.0.0"
}

#variable "ssh_public_key" {
#  default = ""
#}

variable "node_eviction_node_pool_settings" {
  default = false
}

variable "eviction_grace_duration" {
  default = "PT60M"
}

variable "is_force_delete_after_grace_duration" {
  default = true
}


variable "instance_os" {
  default = "Oracle Linux"
}


/********** SSH Key Variables **********/
variable "ssh_public_is_path" {
  description = "Describes if SSH Public Key is located on file or inside code"
  default     = false
}

variable "ssh_public_key" {
  description = "Defines SSH Public Key to be used in order to remotely connect to compute nodepool"
  type        = string

}

variable "ignore_label_prefix_in_node_pool_names" {
  default     = false
  description = "While using label_prefix to add a prefix to many OCI resource names, do not use the label_prefix when naming each node pool. This frees up more characters for the nodepool name. Current limit to node pool name is 32 characters."
  type        = bool
}

#freeform-tags[oke cluster]
#Key
variable "cluster_role_key" {}
variable "cluster_name_key" {}
variable "cluster_env_key" {}

#value
variable "cluster_name_value" {}
variable "cluster_role_value" {}
variable "cluster_env_value" {}
