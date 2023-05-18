#variable "cluster_kube_config_token_version" {
#  default = "2.0.0"
#}

data "oci_containerengine_cluster_kube_config" "OKEKubeConfig" {
  cluster_id = oci_containerengine_cluster.oci_oke_cluster.id

  #Optional
  token_version = var.cluster_kube_config_token_version
}

resource "local_file" "OKEKubeConfigFile" {
  content         = data.oci_containerengine_cluster_kube_config.OKEKubeConfig.content
  filename        = "/tmp/oke_cluster_kubeconfig"
  file_permission = "0400"
}

