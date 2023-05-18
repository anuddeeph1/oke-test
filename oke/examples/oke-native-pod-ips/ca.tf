module "cluster_autoscaler" {
  count               = 3
  source              = "../../cluster-autoscaler"
  kubernetes_version  = module.oci-oke.cluster.kubernetes_version
  node_pool1_version  = module.oci-oke.node_pool1.kubernetes_version
  node_pool2_version  = module.oci-oke.node_pool2.kubernetes_version
  node_pool3_version  = module.oci-oke.node_pool3.kubernetes_version
  cluster_id          = module.oci-oke.cluster.id
  node_pool1_id       = module.oci-oke.node_pool1.id
  node_pool2_id       = module.oci-oke.node_pool2.id
  node_pool3_id       = module.oci-oke.node_pool3.id
  region              = var.region
  compartment_ocid    = var.compartment_ocid
  tenancy_ocid        = var.tenancy_ocid
  max_number_of_nodes = var.max_number_of_nodes
  min_number_of_nodes = var.min_number_of_nodes
}
