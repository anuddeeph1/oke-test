resource "null_resource" "drain_nodes" {
  provisioner "file" {
    content     = local.drain_list_template
    destination = "/home/opc/drainlist.py"
  }

  provisioner "file" {
    content     = local.drain_template
    destination = "/home/opc/drain.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "if [ -f \"$HOME/drainlist.py\" ]; then python3 \"$HOME/drainlist.py\"; rm -f \"$HOME/drainlist.py\";fi",
      "if [ -f \"$HOME/drain.sh\" ]; then bash \"$HOME/drain.sh\"; rm -f \"$HOME/drain.sh\";fi",
      "if [ -f \"$HOME/drainlist.txt\" ]; then cat \"$HOME/drainlist.txt\" >> \"$HOME/drained.txt\"; rm -f \"$HOME/drainlist.txt\";fi",
    ]
  }

  count = var.upgrade_nodepool == true ? 1 : 0
}
