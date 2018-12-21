resource "azurerm_redis_cache" "tf_redis_cache" {
  name                = "${azurerm_resource_group.tf-swarm-cluster-resourcegroup.name}-redis-cache"
  location            = "${azurerm_resource_group.tf-swarm-cluster-resourcegroup.location}"
  resource_group_name = "${azurerm_resource_group.tf-swarm-cluster-resourcegroup.name}"

  capacity = "${var.redisCapacity}"
  family   = "${var.redisSkuFamily}"
  sku_name = "${var.redisSkuName}"

  enable_non_ssl_port = true

  #   subnet_id = "${azurerm_subnet.tf-workers-subnet.id}" # only for Premium

  redis_configuration {
    maxmemory_policy = "volatile-lru" # see Redis documentation: https://redis.io/topics/lru-cache
  }
}

resource "azurerm_redis_firewall_rule" "tf_redis_cache_firewall_rule_allow_swarm_workers" {
  name                = "allowSwarmWorkers"
  redis_cache_name    = "${azurerm_redis_cache.tf_redis_cache.name}"
  resource_group_name = "${azurerm_resource_group.tf-swarm-cluster-resourcegroup.name}"
  start_ip            = "${cidrhost(azurerm_subnet.tf-workers-subnet.address_prefix, 1)}"
  end_ip              = "${cidrhost(azurerm_subnet.tf-workers-subnet.address_prefix, 254)}"
}
