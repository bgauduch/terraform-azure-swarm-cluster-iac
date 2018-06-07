resource "azurerm_resource_group" "tf-swarm-cluster-resourcegroup" {
  name     = "${var.resourceGroupName}"
  location = "${var.azureRegion}"

  tags {
    environnement = "${var.env}"
  }
}
