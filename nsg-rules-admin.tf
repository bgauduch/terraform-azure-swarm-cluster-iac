resource "azurerm_network_security_rule" "tf-admin-nsg-rule-inbound-default" {
  name                        = "admin-nsg-rule-inbound-default"
  priority                    = 2000
  access                      = "Deny"
  direction                   = "Inbound"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = "${azurerm_resource_group.tf-swarm-cluster-resourcegroup.name}"
  network_security_group_name = "${azurerm_network_security_group.tf-admin-subnet-nsg.name}"
}

resource "azurerm_network_security_rule" "tf-admin-nsg-rule-inbound-ssh-cap-office" {
  name                        = "admin-nsg-rule-inbound-ssh-cap-office"
  priority                    = 100
  access                      = "Allow"
  direction                   = "Inbound"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "193.57.249.0/29"
  destination_address_prefix  = "${azurerm_network_interface.tf-admin-nic.private_ip_address}"
  resource_group_name         = "${azurerm_resource_group.tf-swarm-cluster-resourcegroup.name}"
  network_security_group_name = "${azurerm_network_security_group.tf-admin-subnet-nsg.name}"
}

resource "azurerm_network_security_rule" "tf-admin-nsg-rule--inboundssh-cap-vpn" {
  name                        = "admin-nsg-rule-inbound-ssh-cap-vpn"
  priority                    = 110
  access                      = "Allow"
  direction                   = "Inbound"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefixes     = ["193.57.249.10", "193.57.249.11", "193.57.249.12"]
  destination_address_prefix  = "${azurerm_network_interface.tf-admin-nic.private_ip_address}"
  resource_group_name         = "${azurerm_resource_group.tf-swarm-cluster-resourcegroup.name}"
  network_security_group_name = "${azurerm_network_security_group.tf-admin-subnet-nsg.name}"
}
