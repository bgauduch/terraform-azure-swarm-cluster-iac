output "adminPublicIp" {
  value = "azurerm_public_ip.tf-admin-public-ip.ip_address"
}

output "adminFqdn" {
  value = "azurerm_public_ip.tf-admin-public-ip.fqdn"
}

output "managersPublicIps" {
  value = "${join(",",azurerm_public_ip.tf-manager-public-ip.*.ip_address)}"
}

output "managersFqdns" {
  value = "${join(",",azurerm_public_ip.tf-manager-public-ip.*.fqdn)}"
}

output "workersPublicIps" {
  value = "${join(",",azurerm_public_ip.tf-worker-public-ip.*.ip_address)}"
}

output "workersFqdns" {
  value = "${join(",",azurerm_public_ip.tf-worker-public-ip.*.fqdn)}"
}
