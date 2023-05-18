resource "null_resource" "create_service_account" {
  provisioner "file" {
    content     = local.create_service_account_template
    destination = "/home/opc/create_service_account.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "if [ -f \"$HOME/create_service_account.sh\" ]; then bash \"$HOME/create_service_account.sh\"; rm -f \"$HOME/create_service_account.sh\";fi",
    ]
  }

  count = var.create_service_account == true ? 1 : 0
}
