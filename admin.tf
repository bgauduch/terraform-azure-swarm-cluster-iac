resource "azurerm_virtual_machine" "tf-admin-vm" {
  name                = "admin-vm"
  location            = "${azurerm_resource_group.tf-swarm-cluster-resourcegroup.location}"
  resource_group_name = "${azurerm_resource_group.tf-swarm-cluster-resourcegroup.name}"

  network_interface_ids = ["${azurerm_network_interface.tf-admin-nic.id}"]

  vm_size = "${var.adminVmSize}"

  delete_os_disk_on_termination = true

  depends_on = ["azurerm_virtual_machine.tf-manager-vm", "azurerm_virtual_machine.tf-worker-vm"]

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name              = "admin-vm-os-disk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "admin-vm"
    admin_username = "${var.userName}"
  }

  os_profile_linux_config {
    disable_password_authentication = true

    ssh_keys {
      path     = "/home/${var.userName}/.ssh/authorized_keys"
      key_data = "${file("${path.module}/ssh/azure-test-rsa.pub")}"
    }
  }

  tags {
    environment = "${var.env}"
  }

  # the default connection config for provisioners
  connection {
    type        = "ssh"
    user        = "${var.userName}"
    timeout     = "60s"
    private_key = "${file("${path.module}/ssh/azure-test-rsa")}"
    host        = "${azurerm_public_ip.tf-admin-public-ip.ip_address}"
  }

  provisioner "file" {
    source      = "scripts/admin-init.sh"
    destination = "/tmp/admin-init.sh"
  }

  provisioner "file" {
    source      = "ssh/azure-test-rsa"
    destination = "/home/${var.userName}/.ssh/azure-test-rsa"
  }

  provisioner "file" {
    source      = "scripts/vm-init.sh"
    destination = "/tmp/vm-init.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo chmod +x /tmp/admin-init.sh",
      "/tmp/admin-init.sh ${join(",",azurerm_network_interface.tf-manager-nic.*.private_ip_address)} ${join(",",azurerm_network_interface.tf-worker-nic.*.private_ip_address)} ${var.env} ${var.userName}",
    ]
  }
}
