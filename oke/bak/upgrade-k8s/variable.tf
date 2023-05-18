#check worker node active
variable "check_node_active" {
  type = string
}

# upgrade
variable "upgrade_nodepool" {
  type = bool
}

variable "nodepool_upgrade_method" {
  type = string
}

variable "node_pools_to_drain" {
  type = list(string)
}

variable "compartment_ocid" {}
variable "cluster_id" {}

variable "oke_cluster_name" {}

variable "label_prefix" {}
variable "region" {}

# service account
variable "create_service_account" {
  type = bool
}

variable "service_account_name" {}

variable "service_account_namespace" {}

variable "service_account_cluster_role_binding" {}
variable "tenancy_ocid" {}

#variable "path.module" {
#  default = /root/anudeep/TIP-OKE-Multi-NP-CA-Tags/oke/upgrade-k8s
#}
