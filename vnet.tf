/**
* VNET
**/
resource "azurerm_virtual_network" "tf-swarm-cluster-vnet" {
  name                = "swarm-cluster-vnet"
  location            = "${azurerm_resource_group.tf-swarm-cluster-resourcegroup.location}"
  resource_group_name = "${azurerm_resource_group.tf-swarm-cluster-resourcegroup.name}"

  address_space = ["10.0.0.0/16"]
}
