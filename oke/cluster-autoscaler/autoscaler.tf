resource "local_file" "autoscaler_deployment" {
  content  = data.template_file.autoscaler_deployment.rendered
  filename = "${path.module}/autoscaler.yaml"
}

resource "null_resource" "deploy_oke_autoscaler" {
  depends_on = [var.cluster_id, var.node_pool1_id, var.node_pool2_id, var.node_pool3_id,
  local_file.autoscaler_deployment]

  provisioner "local-exec" {
    command = "oci ce cluster create-kubeconfig --region ${var.region} --cluster-id ${var.cluster_id}"
  }

  provisioner "local-exec" {
    command = "kubectl apply -f ${local_file.autoscaler_deployment.filename}"
  }

  provisioner "local-exec" {
    command = "sleep 120"
  }

  provisioner "local-exec" {
    command = "kubectl -n kube-system get cm cluster-autoscaler-status -oyaml"
  }
}

