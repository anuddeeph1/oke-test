resource "null_resource" "check_worker_active" {
  triggers = {
    node_pools = length(data.oci_containerengine_node_pools.all_node_pools.node_pools)
  }

  provisioner "file" {
    content     = local.check_active_worker_template
    destination = "/home/opc/check_active_worker.sh"
    connection {
      host = "127.0.0.1"
      type        = "ssh"
      user        = "root"
      private_key = file("~/.ssh/id_rsa")
    }
  }

  provisioner "local-exec" {
    command = "if [ -f \"$HOME/check_active_worker.sh\" ]; then bash \"$HOME/check_active_worker.sh\"; rm -f \"$HOME/check_active_worker.sh\";fi"
  }

  count = var.check_node_active != "none" ? 1 : 0
}
