/**
* GLOBAL
**/
variable "env" {
  description = "the environment"
  type        = "string"
  default     = "prod"
}

variable "azureRegion" {
  description = "The Azure Region to be use"
  type        = "string"
  default     = "West Europe"
}

variable "resourceGroupName" {
  description = "the resource group name"
  type        = "string"
  default     = "swarm-cluster-resourcegroup"
}

/**
* AG SIZING
**/

variable "agType" {
  description = ""
  type        = "string"
  default     = ""       # Standard_Small, Standard_Medium, Standard_Large, WAF_Medium, AF_Large
}

variable "agTier" {
  description = ""
  type        = "string"
  default     = ""       # Standard, WAF
}

variable "agCapacity" {
  description = ""
  type        = "string"
  default     = ""       # from 1 to 10
}

/**
* NETWORKING
**/

# variable "agPublicIpFqdnName" {
#   description = "The FQDN to use on Application Gateway public IP"
#   type        = "string"
#   default     = "azure-terraform-swarm-cluster-ag-pubic-ip-bga"
# }


/* description =""
  type ="string"
  default="" */

