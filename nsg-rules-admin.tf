resource "azurerm_network_security_rule" "tf-admin-nsg-rule-ssh-cap-office" {
  name                        = "admin-nsg-rule-ssh-cap-office"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "193.57.249.0/29"
  destination_address_prefix  = "${azurerm_network_interface.tf-admin-nic.private_ip_address}"
  resource_group_name         = "${azurerm_resource_group.tf-swarm-cluster-resourcegroup.name}"
  network_security_group_name = "${azurerm_network_security_group.tf-admin-subnet-nsg.name}"
}

resource "azurerm_network_security_rule" "tf-admin-nsg-rule-ssh-cap-vpn" {
  name                        = "admin-nsg-rule-ssh-cap-vpn"
  priority                    = 110
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefixes     = ["193.57.249.10", "193.57.249.11", "193.57.249.12"]
  destination_address_prefix  = "${azurerm_network_interface.tf-admin-nic.private_ip_address}"
  resource_group_name         = "${azurerm_resource_group.tf-swarm-cluster-resourcegroup.name}"
  network_security_group_name = "${azurerm_network_security_group.tf-admin-subnet-nsg.name}"
}
