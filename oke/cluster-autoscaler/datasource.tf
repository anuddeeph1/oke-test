data "template_file" "autoscaler_deployment" {

  template = file("${path.module}/templates/autoscaler.template.yaml")
  vars = {
    autoscaler_image = "${lookup(local.autoscaler_image, var.kubernetes_version)}"
    min_nodes        = "${var.min_number_of_nodes}"
    max_nodes        = "${var.max_number_of_nodes}"
    node_pool1_id     = "${var.node_pool1_id}"
    node_pool2_id     = "${var.node_pool2_id}"
    node_pool3_id     = "${var.node_pool3_id}"
  }
}
