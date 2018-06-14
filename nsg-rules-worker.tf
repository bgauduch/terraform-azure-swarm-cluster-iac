resource "azurerm_network_security_rule" "tf-worker-nsg-rule-inbound-default" {
  name                        = "worker-nsg-rule-inbound-default"
  priority                    = 2000
  access                      = "Deny"
  direction                   = "Inbound"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = "${azurerm_resource_group.tf-swarm-cluster-resourcegroup.name}"
  network_security_group_name = "${azurerm_network_security_group.tf-worker-subnet-nsg.name}"
}

resource "azurerm_network_security_rule" "tf-worker-nsg-rule-inbound-ssh-from-admin" {
  name                        = "worker-nsg-rule-inbound-ssh-from-admin"
  priority                    = 100
  access                      = "Allow"
  direction                   = "Inbound"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "${azurerm_subnet.tf-admin-subnet.address_prefix}"
  destination_address_prefix  = "${azurerm_subnet.tf-workers-subnet.address_prefix}"
  resource_group_name         = "${azurerm_resource_group.tf-swarm-cluster-resourcegroup.name}"
  network_security_group_name = "${azurerm_network_security_group.tf-worker-subnet-nsg.name}"
}

resource "azurerm_network_security_rule" "tf-worker-nsg-rule-inbound-cluster-management" {
  name                        = "worker-nsg-rule-inbound-cluster-management"
  priority                    = 200
  access                      = "Allow"
  direction                   = "Inbound"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "2377"
  source_address_prefix       = "${azurerm_subnet.tf-managers-subnet.address_prefix}"
  destination_address_prefix  = "${azurerm_subnet.tf-workers-subnet.address_prefix}"
  resource_group_name         = "${azurerm_resource_group.tf-swarm-cluster-resourcegroup.name}"
  network_security_group_name = "${azurerm_network_security_group.tf-worker-subnet-nsg.name}"
}

resource "azurerm_network_security_rule" "tf-worker-nsg-rule-inbound-cluster-communication" {
  name                        = "worker-nsg-rule-inbound-cluster-communication"
  priority                    = 210
  access                      = "Allow"
  direction                   = "Inbound"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "7946"
  source_address_prefix       = "${azurerm_subnet.tf-managers-subnet.address_prefix}"
  destination_address_prefix  = "${azurerm_subnet.tf-workers-subnet.address_prefix}"
  resource_group_name         = "${azurerm_resource_group.tf-swarm-cluster-resourcegroup.name}"
  network_security_group_name = "${azurerm_network_security_group.tf-worker-subnet-nsg.name}"
}

resource "azurerm_network_security_rule" "tf-worker-nsg-rule-inbound-cluster-overlay" {
  name                        = "worker-nsg-rule-inbound-cluster-overlay"
  priority                    = 220
  access                      = "Allow"
  direction                   = "Inbound"
  protocol                    = "Udp"
  source_port_range           = "*"
  destination_port_range      = "4789"
  source_address_prefix       = "${azurerm_subnet.tf-managers-subnet.address_prefix}"
  destination_address_prefix  = "${azurerm_subnet.tf-workers-subnet.address_prefix}"
  resource_group_name         = "${azurerm_resource_group.tf-swarm-cluster-resourcegroup.name}"
  network_security_group_name = "${azurerm_network_security_group.tf-worker-subnet-nsg.name}"
}
