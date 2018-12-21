resource "azurerm_resource_group" "tf-swarm-cluster-resourcegroup" {
  name     = "${var.clusterResourceGroupName}"
  location = "${var.azureRegion}"

  tags {
    environnement = "${var.env}"
  }
}

resource "azurerm_resource_group" "tf_ag_resourcegroup" {
  name     = "${var.agResourceGroupName}"
  location = "${var.azureRegion}"

  tags {
    environnement = "${var.env}"
  }
}
