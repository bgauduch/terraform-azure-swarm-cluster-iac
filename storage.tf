resource "azurerm_storage_account" "tf-cluster-storage-account" {
  name                     = "${var.storageAccountName}"
  resource_group_name      = "${azurerm_resource_group.tf-swarm-cluster-resourcegroup.name}"
  location                 = "${azurerm_resource_group.tf-swarm-cluster-resourcegroup.location}"
  account_kind             = "StorageV2"
  account_tier             = "${var.storageAccountTier}"
  account_replication_type = "${var.storageAccountReplication}"

  tags {
    environment = "${var.env}"
  }
}
