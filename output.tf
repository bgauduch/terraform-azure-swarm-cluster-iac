output "adminPublicIp" {
  value = "${azurerm_public_ip.tf-admin-public-ip.ip_address}"
}

output "adminFqdn" {
  value = "${azurerm_public_ip.tf-admin-public-ip.fqdn}"
}
