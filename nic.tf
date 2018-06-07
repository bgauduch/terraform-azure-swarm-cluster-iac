/**
* NICs
**/
resource "azurerm_network_interface" "tf-admin-nic" {
  name                = "admin-nic"
  resource_group_name = "${azurerm_resource_group.tf-swarm-cluster-resourcegroup.name}"
  location            = "${azurerm_resource_group.tf-swarm-cluster-resourcegroup.location}"

  ip_configuration {
    name                          = "admin-nic-ip-config"
    subnet_id                     = "${azurerm_subnet.tf-admin-subnet.id}"
    private_ip_address_allocation = "dynamic"
    public_ip_address_id          = "${azurerm_public_ip.tf-admin-public-ip.id}"
  }
}

resource "azurerm_network_interface" "tf-manager-nic" {
  count = "${var.numberOfManagers}"

  name                = "manager-nic-${count.index}"
  resource_group_name = "${azurerm_resource_group.tf-swarm-cluster-resourcegroup.name}"
  location            = "${azurerm_resource_group.tf-swarm-cluster-resourcegroup.location}"

  # WARNING : need to choose a compatible VM Size to enable accelerated networking (usually big VM sizes) !
  # enable_accelerated_networking = true 

  ip_configuration {
    name                          = "manager-nic-ip-config-${count.index}"
    subnet_id                     = "${azurerm_subnet.tf-managers-subnet.id}"
    private_ip_address_allocation = "dynamic"
    public_ip_address_id          = "${azurerm_public_ip.tf-manager-public-ip.*.id[count.index]}"
  }
}

resource "azurerm_network_interface" "tf-worker-nic" {
  count = "${var.numberOfWorkers}"

  name                = "worker-nic-${count.index}"
  resource_group_name = "${azurerm_resource_group.tf-swarm-cluster-resourcegroup.name}"
  location            = "${azurerm_resource_group.tf-swarm-cluster-resourcegroup.location}"

  # WARNING : need to choose a compatible VM Size to enable accelerated networking (usually big VM sizes) !
  # enable_accelerated_networking = true

  ip_configuration {
    name                          = "worker-nic-ip-config-${count.index}"
    subnet_id                     = "${azurerm_subnet.tf-workers-subnet.id}"
    private_ip_address_allocation = "dynamic"
    public_ip_address_id          = "${azurerm_public_ip.tf-worker-public-ip.*.id[count.index]}"
  }
}
