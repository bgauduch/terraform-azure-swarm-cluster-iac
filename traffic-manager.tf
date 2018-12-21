resource "azurerm_traffic_manager_profile" "tf_traffic_manager_profile" {
  name                = "${var.env}-traffic-manager-profile"
  resource_group_name = "${azurerm_resource_group.tf_ag_resourcegroup.name}"

  traffic_routing_method = "Priority" # can be one of 'Performance', 'Priority', 'Weighted' or 'Geographic', see: https://docs.microsoft.com/en-us/azure/traffic-manager/traffic-manager-routing-methods

  dns_config {
    relative_name = "${azurerm_resource_group.tf_ag_resourcegroup.name}"
    ttl           = 100
  }

  monitor_config {
    protocol = "http"
    port     = 80
    path     = "/"
  }

  tags {
    environment = "${var.env}"
  }
}

resource "azurerm_traffic_manager_endpoint" "tf_traffic_manager_endpoint" {
  name                = "${var.env}-traffic-manager-endpoint"
  resource_group_name = "${azurerm_resource_group.tf_ag_resourcegroup.name}"
  profile_name        = "${azurerm_traffic_manager_profile.tf_traffic_manager_profile.name}"

  type               = "azureEndpoints"
  target_resource_id = "${azurerm_public_ip.tf_ag_public_ip.id}"
  priority           = 1
}
