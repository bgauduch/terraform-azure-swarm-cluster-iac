resource "azurerm_mysql_server" "tf_mysql_server" {
  name                = "${azurerm_resource_group.tf-swarm-cluster-resourcegroup.name}-mysql-server"
  location            = "${azurerm_resource_group.tf-swarm-cluster-resourcegroup.location}"
  resource_group_name = "${azurerm_resource_group.tf-swarm-cluster-resourcegroup.name}"

  sku {
    name     = "${var.mysqlServerSkuName}"
    capacity = "${var.mysqlServerSkuCapacity}"
    tier     = "${var.mysqlServerSkuTier}"
    family   = "${var.mysqlServerSkuFamily}"
  }

  storage_profile {
    storage_mb            = "${var.mysqlStorageSize}"
    backup_retention_days = "${var.mysqlBackupRetentionDays}"
    geo_redundant_backup  = "${var.mysqlGeoredundantBackup}"
  }

  administrator_login          = "${var.mysqlServerAdminLogin}"
  administrator_login_password = "${var.mysqlServerAdminPassword}"
  version                      = "5.7"
  ssl_enforcement              = "${var.mysqlEnforceSSL}"
}

# TODO
# resource "azurerm_mysql_firewall_rule" "tf_mysql_firewall_allow_worker_subnet" {
#   name                = "mysql-firewall-allow-worker-subnet"
#   resource_group_name = "${azurerm_resource_group.tf-swarm-cluster-resourcegroup.name}"
#   server_name         = "${azurerm_mysql_server.tf_mysql_server.name}"
#   start_ip_address    = "40.112.8.12"
#   end_ip_address      = "40.112.8.12"
# }

resource "azurerm_mysql_database" "tf_mysql_database" {
  name                = "${var.mysqlDatabaseName}"
  resource_group_name = "${azurerm_resource_group.tf-swarm-cluster-resourcegroup.name}"
  server_name         = "${azurerm_mysql_server.tf_mysql_server.name}"
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}
