resource "azurerm_network_security_rule" "tf-admin-nsg-rule-ssh" {
  name                        = "admin-nsg-rule-ssh"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = "${azurerm_resource_group.tf-swarm-cluster-resourcegroup.name}"
  network_security_group_name = "${azurerm_network_security_group.tf-admin-subnet-nsg.name}"
}
