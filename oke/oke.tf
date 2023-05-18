## Copyright (c) 2022 Oracle and/or its affiliates.
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

resource "tls_private_key" "public_private_key_pair" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "oci_containerengine_cluster" "oci_oke_cluster" {
  compartment_id     = var.compartment_ocid
  kubernetes_version = var.k8s_version
  name               = var.oke_cluster_name
  vcn_id             = var.use_existing_vcn ? var.vcn_id : oci_core_vcn.oke_vcn[0].id
  kms_key_id         = var.kms_key_id


  dynamic "endpoint_config" {
    for_each = var.vcn_native ? [1] : []
    content {
      is_public_ip_enabled = var.is_api_endpoint_subnet_public
      subnet_id            = var.use_existing_vcn ? var.api_endpoint_subnet_id : oci_core_subnet.oke_api_endpoint_subnet[0].id
      nsg_ids              = var.use_existing_vcn ? var.api_endpoint_nsg_ids : []
    }
  }

  dynamic "cluster_pod_network_options" {
    for_each = var.oci_vcn_ip_native == true ? [1] : []
    content {
      cni_type = "OCI_VCN_IP_NATIVE"
    }
  }

  options {
    #service_lb_subnet_ids = [var.use_existing_vcn ? var.lb_subnet_id : oci_core_subnet.oke_lb_subnet[0].id]

    add_ons {
      is_kubernetes_dashboard_enabled = var.cluster_options_add_ons_is_kubernetes_dashboard_enabled
      is_tiller_enabled               = var.cluster_options_add_ons_is_tiller_enabled
    }

    admission_controller_options {
      is_pod_security_policy_enabled = var.cluster_options_admission_controller_options_is_pod_security_policy_enabled
    }

    dynamic "kubernetes_network_config" {
      for_each = var.oci_vcn_ip_native == true ? [] : [1]
      content {
        pods_cidr     = var.pods_cidr
        services_cidr = var.services_cidr
      }
    }
  }
  freeform_tags = { "${var.cluster_name_key}" = "${var.cluster_name_value}", "${var.cluster_role_key}" = "${var.cluster_role_value}", "${var.cluster_env_key}" = "${var.cluster_env_value}" }
  #defined_tags  = var.defined_tags_cluster
}

resource "oci_containerengine_node_pool" "oci_oke_node_pool" {
  for_each           = var.node_pools
  cluster_id         = oci_containerengine_cluster.oci_oke_cluster.id
  compartment_id     = var.compartment_ocid
  kubernetes_version = each.value.np_k8s_version
  #kubernetes_version = local.oci_oke_node_pool.var.np_k8s_version
  #name               = var.pool_name
  name       = var.label_prefix == "none" || var.ignore_label_prefix_in_node_pool_names ? each.key : "${var.label_prefix}-${each.key}"
  node_shape = var.node_shape
  depends_on = [oci_containerengine_cluster.oci_oke_cluster]
  #freeform_tags      = merge(lookup(var.freeform_tags, "node_pool", {}), lookup(each.value, "nodepool_freeform_tags", {}))
  #defined_tags       = merge(lookup(var.defined_tags, "node_pool", {}), lookup(each.value, "nodepool_defined_tags", {}))
  #freeform_tags = var.freeform_tags_nodepool
  #defined_tags  = var.defined_tags_nodepool

  initial_node_labels {
    key   = var.node_pool_initial_node_labels_key
    value = var.node_pool_initial_node_labels_value
  }

  node_source_details {
    image_id = var.node_image_id == "" ? element([for source in data.oci_containerengine_node_pool_option.oci_oke_node_pool_option.sources : source.image_id if length(regexall("Oracle-Linux-${var.node_linux_version}-20[0-9]*.*", source.source_name)) > 0], 0) : each.value.node_image_id
    #image_id                = var.node_image_id == "" ? element([for source in data.oci_containerengine_node_pool_option.oci_oke_node_pool_option.sources : source.image_id if length(regexall(local.node_image_regex, source.source_name)) > 0], 0) : var.node_image_id
    source_type             = "IMAGE"
    boot_volume_size_in_gbs = var.node_pool_boot_volume_size_in_gbs
  }

  ssh_public_key = var.ssh_public_key != "" ? var.ssh_public_key : tls_private_key.public_private_key_pair.public_key_openssh

  node_config_details {
    dynamic "placement_configs" {
      #iterator = pc_iter
      #for_each = local.availability_domains #data.oci_identity_availability_domains.ADs.availability_domains
      iterator = ad_iterator
      for_each = [for n in lookup(each.value, "placement_ads", local.ad_numbers) :
        length(local.ad_numbers) == 1 ? local.ad_number_to_name[1] : local.ad_number_to_name[n]
      ]
      content {
        #availability_domain = pc_iter.value.name  
        availability_domain = ad_iterator.value
        subnet_id           = var.use_existing_vcn ? var.nodepool_subnet_id : oci_core_subnet.oke_nodepool_subnet[0].id
      }
    }
    #size = var.node_count


    dynamic "node_pool_pod_network_option_details" {
      for_each = var.oci_vcn_ip_native == true ? [1] : []
      content {
        cni_type          = "OCI_VCN_IP_NATIVE"
        max_pods_per_node = var.max_pods_per_node
        pod_nsg_ids       = var.use_existing_nsg ? var.pods_nsg_ids : []
        pod_subnet_ids    = var.use_existing_vcn ? [var.pods_subnet_id] : []
      }
    }
    # allow zero-sized node pools
    size = max(0, lookup(each.value, "node_pool_size", 0))
  }

  dynamic "node_shape_config" {
    #for_each = length(regexall("Flex", var.node_shape)) > 0 ? [1] : []
    #content {
    #  ocpus         = var.node_ocpus
    #  memory_in_gbs = var.node_memory
    #}
    for_each = length(regexall("Flex", lookup(each.value, "shape", "VM.Standard.E4.Flex"))) > 0 ? [1] : []
    content {
      ocpus         = max(1, lookup(each.value, "ocpus", 1))
      memory_in_gbs = (lookup(each.value, "memory", 16) / lookup(each.value, "ocpus", 1)) > 64 ? (lookup(each.value, "ocpus", 1) * 64) : lookup(each.value, "memory", 16)
    }
  }

  dynamic "node_eviction_node_pool_settings" {
    for_each = var.node_eviction_node_pool_settings == true ? [1] : []
    content {

      eviction_grace_duration              = var.eviction_grace_duration
      is_force_delete_after_grace_duration = var.is_force_delete_after_grace_duration
    }
  }

}
