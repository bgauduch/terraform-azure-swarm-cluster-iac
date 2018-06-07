/**
* Public IPs
**/

resource "azurerm_public_ip" "tf-admin-public-ip" {
  name                         = "admin-public-ip"
  resource_group_name          = "${azurerm_resource_group.tf-swarm-cluster-resourcegroup.name}"
  location                     = "${azurerm_resource_group.tf-swarm-cluster-resourcegroup.location}"
  public_ip_address_allocation = "static"
  domain_name_label            = "azure-terraform-swarm-cluster-admin-pubic-ip"
}

resource "azurerm_public_ip" "tf-manager-public-ip" {
  count                        = "${var.numberOfManagers}"
  name                         = "manager-public-ip-${count.index}"
  resource_group_name          = "${azurerm_resource_group.tf-swarm-cluster-resourcegroup.name}"
  location                     = "${azurerm_resource_group.tf-swarm-cluster-resourcegroup.location}"
  public_ip_address_allocation = "static"
  domain_name_label            = "azure-terraform-swarm-cluster-manager-pubic-ip-${count.index}"
}

resource "azurerm_public_ip" "tf-worker-public-ip" {
  count                        = "${var.numberOfWorkers}"
  name                         = "worker-public-ip-${count.index}"
  resource_group_name          = "${azurerm_resource_group.tf-swarm-cluster-resourcegroup.name}"
  location                     = "${azurerm_resource_group.tf-swarm-cluster-resourcegroup.location}"
  public_ip_address_allocation = "static"
  domain_name_label            = "azure-terraform-swarm-cluster-worker-pubic-ip-${count.index}"
}
