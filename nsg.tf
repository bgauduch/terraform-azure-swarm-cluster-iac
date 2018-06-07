resource "azurerm_network_security_group" "tf-admin-subnet-nsg" {
  name                = "admin-subnet-nsg"
  location            = "${azurerm_resource_group.tf-swarm-cluster-resourcegroup.location}"
  resource_group_name = "${azurerm_resource_group.tf-swarm-cluster-resourcegroup.name}"

  tags {
    environment = "${var.env}"
  }
}

resource "azurerm_network_security_group" "tf-manager-subnet-nsg" {
  name                = "manager-subnet-nsg"
  location            = "${azurerm_resource_group.tf-swarm-cluster-resourcegroup.location}"
  resource_group_name = "${azurerm_resource_group.tf-swarm-cluster-resourcegroup.name}"

  tags {
    environment = "${var.env}"
  }
}

resource "azurerm_network_security_group" "tf-worker-subnet-nsg" {
  name                = "worker-subnet-nsg"
  location            = "${azurerm_resource_group.tf-swarm-cluster-resourcegroup.location}"
  resource_group_name = "${azurerm_resource_group.tf-swarm-cluster-resourcegroup.name}"

  tags {
    environment = "${var.env}"
  }
}
