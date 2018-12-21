# resource "azurerm_application_gateway" "tf-cluster-ag" {
#   name                = "cluster-ag"
#   location            = "${azurerm_resource_group.tf-swarm-cluster-resourcegroup.location}"
#   resource_group_name = "${azurerm_resource_group.tf-swarm-cluster-resourcegroup.name}"

#   sku {
#     name     = "Standard_Small"
#     tier     = "Standard"
#     capacity = 2
#   }

#   gateway_ip_configuration {
#     name      = "cluster-ag-ip-configuration"
#     subnet_id = "${azurerm_subnet.tf-ag-subnet.id}"
#   }

#   frontend_port {
#     name = "${azurerm_virtual_network.tf-swarm-cluster-vnet.name}-ag-frontend-port"
#     port = 80
#   }

#   frontend_ip_configuration {
#     name                 = "${azurerm_virtual_network.tf-swarm-cluster-vnet.name}-ag-frontend-ip-conf"
#     public_ip_address_id = "${azurerm_public_ip.tf-ag-public-ip.id}"
#   }

#   backend_address_pool {
#     name            = "${azurerm_virtual_network.tf-swarm-cluster-vnet.name}-ag-backend-address-pool"
#     ip_address_list = "${azurerm_network_interface.tf-worker-nic.*.private_ip_address}"
#   }

#   backend_http_settings {
#     name                  = "${azurerm_virtual_network.tf-swarm-cluster-vnet.name}-ag-backend-http-settings"
#     port                  = 80
#     protocol              = "Http"
#     cookie_based_affinity = "Disabled"
#     request_timeout       = 30
#   }

#   http_listener {
#     name                           = "${azurerm_virtual_network.tf-swarm-cluster-vnet.name}-ag-http-listener"
#     frontend_ip_configuration_name = "${azurerm_virtual_network.tf-swarm-cluster-vnet.name}-ag-frontend-ip-conf"
#     frontend_port_name             = "${azurerm_virtual_network.tf-swarm-cluster-vnet.name}-ag-frontend-port"
#     protocol                       = "Http"
#   }

#   request_routing_rule {
#     name                       = "${azurerm_virtual_network.swarm-cluster-vnet.name}-ag-request-rule"
#     rule_type                  = "Basic"
#     http_listener_name         = "${azurerm_virtual_network.swarm-cluster-vnet.name}-ag-http-listener"
#     backend_address_pool_name  = "${azurerm_virtual_network.swarm-cluster-vnet.name}-ag-backend-address-pool"
#     backend_http_settings_name = "${azurerm_virtual_network.swarm-cluster-vnet.name}-ag-backend-http-settings"
#   }
# }

# resource "azurerm_subnet" "tf-ag-subnet" {
#   name                      = "ag-subnet"
#   resource_group_name       = "${azurerm_resource_group.tf-swarm-cluster-resourcegroup.name}"
#   virtual_network_name      = "${azurerm_virtual_network.tf-swarm-cluster-vnet.name}"
#   network_security_group_id = "${azurerm_network_security_group.tf-ag-subnet-nsg.id}"

#   address_prefix = "${var.workerSubnetRange}"
# }

# resource "azurerm_public_ip" "tf-ag-public-ip" {
#   name                         = "ag-public-ip"
#   resource_group_name          = "${azurerm_resource_group.tf-swarm-cluster-resourcegroup.name}"
#   location                     = "${azurerm_resource_group.tf-swarm-cluster-resourcegroup.location}"
#   public_ip_address_allocation = "static"
#   domain_name_label            = "${var.agPublicIpFqdnName}"
# }

# resource "azurerm_network_security_group" "tf-ag-subnet-nsg" {
#   name                = "ag-subnet-nsg"
#   location            = "${azurerm_resource_group.tf-swarm-cluster-resourcegroup.location}"
#   resource_group_name = "${azurerm_resource_group.tf-swarm-cluster-resourcegroup.name}"

#   tags {
#     environment = "${var.env}"
#   }
# }
