resource "azurerm_availability_set" "tf-workers-availability-set" {
  name                = "cluster-availability-set"
  location            = "${azurerm_resource_group.tf-swarm-cluster-resourcegroup.location}"
  resource_group_name = "${azurerm_resource_group.tf-swarm-cluster-resourcegroup.name}"

  platform_update_domain_count = "${var.updateDomainCount}"
  platform_fault_domain_count  = "${var.faultDomainCount}"
  managed                      = true # /!\ needed for VM with managed disk

  tags {
    environment = "${var.env}"
  }
}

resource "azurerm_availability_set" "tf-managers-availability-set" {
  name                = "cluster-availability-set"
  location            = "${azurerm_resource_group.tf-swarm-cluster-resourcegroup.location}"
  resource_group_name = "${azurerm_resource_group.tf-swarm-cluster-resourcegroup.name}"

  platform_update_domain_count = "${var.updateDomainCount}"
  platform_fault_domain_count  = "${var.faultDomainCount}"
  managed                      = true # /!\ needed for VM with managed disk

  tags {
    environment = "${var.env}"
  }
}
