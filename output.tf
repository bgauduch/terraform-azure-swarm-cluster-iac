output "adminPublicIp" {
  value = "${azurerm_public_ip.tf-admin-public-ip.ip_address}"
}

output "adminFqdn" {
  value = "${azurerm_public_ip.tf-admin-public-ip.fqdn}"
}

output "mysqlServerFqdn" {
  value = "${azurerm_mysql_server.tf_mysql_server.fqdn}"
}

output "redisServerHostname" {
  value = "${azurerm_redis_cache.tf_redis_cache.hostname}"
}

output "redisServerSslPort" {
  value = "${azurerm_redis_cache.tf_redis_cache.ssl_port}"
}
