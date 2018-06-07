# data "external" "swarm_tokens" {
#   program = ["/scripts/fetch-swarm-tokens.sh"]

#   query = {
#     host = "${azurerm_public_ip.tf-manager-public-ip.0.ip_address}"
#   }

#   depends_on = ["azurerm_virtual_machine.tf-manager-vm"]
# }
