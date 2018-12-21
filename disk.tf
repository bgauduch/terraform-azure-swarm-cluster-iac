# Data disk are not used anymore on Swarm Workers !
# resource "azurerm_managed_disk" "tf-worker-data-disk" {
#   count = "${var.numberOfWorkers}"
#   name                = "worker-data-disk-${count.index}"
#   location            = "${azurerm_resource_group.tf-swarm-cluster-resourcegroup.location}"
#   resource_group_name = "${azurerm_resource_group.tf-swarm-cluster-resourcegroup.name}"
#   storage_account_type = "${var.workerDataDiskType}"
#   create_option        = "Empty"
#   disk_size_gb         = "${var.workerDataDiskSize}"
# }

