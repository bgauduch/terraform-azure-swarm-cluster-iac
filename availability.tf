resource "azurerm_availability_set" "tf-cluster-availability-set" {
  name                = "cluster-availability-set"
  location            = "${azurerm_resource_group.tf-swarm-cluster-resourcegroup.location}"
  resource_group_name = "${azurerm_resource_group.tf-swarm-cluster-resourcegroup.name}"

  platform_update_domain_count = 10
  platform_fault_domain_count  = 3
  managed                      = true

  tags {
    environment = "${var.env}"
  }
}
