resource "nirmata_cluster_registered" "oke-registered" {
  name         = "oke-priv-inplace-test-cluster"
  cluster_type = "default-add-ons"
}

terraform {
  required_providers {

    nirmata = {
      source  = "nirmata/nirmata"
      version = "1.1.8-rc2"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.16.1"
    }

    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "1.14.0"
    }
  }
}

provider "oci" {
  region = "us-phoenix-1"
}


provider "kubectl" {
  config_path = "/tmp/oke_cluster_kubeconfig"
}


resource "null_resource" "configure_kubectl" {
  provisioner "local-exec" {
    command = "kubectl config use-context $(kubectl config get-contexts --kubeconfig /tmp/oke_cluster_kubeconfig --no-headers -o name) --kubeconfig /tmp/oke_cluster_kubeconfig"
  }
  depends_on = [
    module.oci-oke.cluster,
    module.oci-oke.node_pool,
  ]
}

// configure the Nirmata provider
provider "nirmata" {

  // Nirmata address.
  url = "https://nirmata.io"

  // Nirmata API Key. Also configurable using the environment variable NIRMATA_TOKEN.
  token = var.token
}

data "kubectl_filename_list" "manifests" {
  pattern = "${nirmata_cluster_registered.oke-registered.controller_yamls_folder}/*"
}

// apply the controller YAMLs
resource "kubectl_manifest" "test" {
  count     = nirmata_cluster_registered.oke-registered.controller_yamls_count
  yaml_body = file(element(data.kubectl_filename_list.manifests.matches, count.index))
}
