resource "azurerm_virtual_machine" "tf-manager-vm" {
  count = "${var.numberOfManagers}"

  name                = "manager-vm-${count.index}"
  location            = "${azurerm_resource_group.tf-swarm-cluster-resourcegroup.location}"
  resource_group_name = "${azurerm_resource_group.tf-swarm-cluster-resourcegroup.name}"

  network_interface_ids = ["${azurerm_network_interface.tf-manager-nic.*.id[count.index]}"]
  availability_set_id   = "${azurerm_availability_set.tf-cluster-availability-set.id}"

  vm_size = "${var.managerVmSize}"

  delete_os_disk_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name              = "manager-vm-os-disk-${count.index}"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "manager-${count.index}"
    admin_username = "azureuser"
  }

  os_profile_linux_config {
    disable_password_authentication = true

    ssh_keys {
      path     = "/home/azureuser/.ssh/authorized_keys"
      key_data = "${file("${path.module}/ssh/azure-test-rsa.pub")}"
    }
  }

  tags {
    environment = "${var.env}"
  }

  # the default connection config for provisioners
  connection {
    type        = "ssh"
    user        = "azureuser"
    timeout     = "30s"
    private_key = "${file("${path.module}/ssh/azure-test-rsa")}"
    host        = "${azurerm_public_ip.tf-manager-public-ip.*.ip_address[count.index]}"
  }

  # send vm initialisation script
  provisioner "file" {
    source      = "scripts/docker-install.sh"
    destination = "/tmp/docker-install.sh"
  }

  # run scripts
  provisioner "remote-exec" {
    inline = [
      "sudo chmod +x /tmp/docker-install.sh",
      "/tmp/docker-install.sh",
    ]
  }
}
