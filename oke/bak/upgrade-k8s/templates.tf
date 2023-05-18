locals {
  # scripting templates

  check_active_worker_template = templatefile("${path.module}/scripts/check_worker_active.template.sh",
    {
      check_node_active = var.check_node_active
      total_nodes       = local.total_nodes
    }
  )

  create_service_account_template = templatefile("${path.module}/scripts/create_service_account.template.sh",
    {
      service_account_name                 = var.service_account_name
      service_account_namespace            = var.service_account_namespace
      service_account_cluster_role_binding = local.service_account_cluster_role_binding_name
    }
  )

  drain_template = templatefile("${path.module}/scripts/drain.template.sh", {})

  drain_list_template = templatefile("${path.module}/scripts/drainlist.py",
    {
      cluster_id     = var.cluster_id
      compartment_id = var.compartment_ocid
      region         = var.region
      pools_to_drain = var.label_prefix == "none" ? trim(join(",", formatlist("'%s'", var.node_pools_to_drain)), "'") : trim(join(",", formatlist("'%s-%s'", var.label_prefix, var.node_pools_to_drain)), "'")
    }
  )

  generate_kubeconfig_template = templatefile("${path.module}/scripts/generate_kubeconfig.template.sh",
    {
      cluster-id = var.cluster_id
      region     = var.region
    }
  )
}
