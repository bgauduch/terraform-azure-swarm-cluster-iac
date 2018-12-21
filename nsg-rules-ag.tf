resource "azurerm_network_security_rule" "tf_ag_nsg_rule_inbound_default_deny" {
  name                        = "ag-nsg-rule-inbound-default-deny"
  priority                    = 2000
  access                      = "Deny"
  direction                   = "Inbound"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = "${azurerm_resource_group.tf_ag_resourcegroup.name}"
  network_security_group_name = "${azurerm_network_security_group.tf_ag_subnet_nsg.name}"
}

resource "azurerm_network_security_rule" "tf_ag_nsg_rule_inbound_http_from_web" {
  name                        = "ag-nsg-rule-inbound-http-from-web"
  priority                    = 100
  access                      = "Allow"
  direction                   = "Inbound"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "${azurerm_subnet.tf_ag_subnet.address_prefix}"
  resource_group_name         = "${azurerm_resource_group.tf_ag_resourcegroup.name}"
  network_security_group_name = "${azurerm_network_security_group.tf_ag_subnet_nsg.name}"
}

resource "azurerm_network_security_rule" "tf_ag_nsg_rule_inbound_https_from_web" {
  name                        = "ag-nsg-rule-inbound-https-from-web"
  priority                    = 110
  access                      = "Allow"
  direction                   = "Inbound"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "*"
  destination_address_prefix  = "${azurerm_subnet.tf_ag_subnet.address_prefix}"
  resource_group_name         = "${azurerm_resource_group.tf_ag_resourcegroup.name}"
  network_security_group_name = "${azurerm_network_security_group.tf_ag_subnet_nsg.name}"
}

resource "azurerm_network_security_rule" "tf_ag_nsg_rule_inbound_probe_from_web" {
  name                        = "ag-nsg-rule-inbound-probe-from-web"
  priority                    = 200
  access                      = "Allow"
  direction                   = "Inbound"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "65503-65534"
  source_address_prefix       = "*"
  destination_address_prefix  = "${azurerm_subnet.tf_ag_subnet.address_prefix}"
  resource_group_name         = "${azurerm_resource_group.tf_ag_resourcegroup.name}"
  network_security_group_name = "${azurerm_network_security_group.tf_ag_subnet_nsg.name}"
}