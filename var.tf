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

variable "numberOfManagers" {
  description = "The number of manager of the swarm cluster"
  type        = "string"
  default     = "1"
}

variable "numberOfWorkers" {
  description = "The number of manager of the swarm cluster"
  type        = "string"
  default     = "1"
}

/**
* NETWORK
**/

variable "vnetRange" {
  description = "THe IP range for the VNET"
  type        = "string"
  default     = "10.0.0.0/16"
}

variable "adminSubnetRange" {
  description = "The ip range for the admin subnet"
  type        = "string"
  default     = "10.0.0.0/24"                       //"${cidrsubnet(var.vnetRange, 8, 1)}"
}

variable "managerSubnetRange" {
  description = "The ip range for the manager subnet"
  type        = "string"
  default     = "10.0.1.0/24"
}

variable "workerSubnetRange" {
  description = "The ip range for the worker subnet"
  type        = "string"
  default     = "10.0.2.0/24"
}

variable "adminPublicIpFqdnName" {
  description = "The FQDN to use on admin public IP"
  type        = "string"
  default     = "azure-terraform-swarm-cluster-admin-pubic-ip-bga"
}

/**
* STORAGE
**/

variable "workerDataDiskSize" {
  description = "available disk size"
  type        = "string"
  default     = "32"
}

variable "workerDataDiskType" {
  description = "managers data disk type"
  type        = "string"
  default     = "Standard_LRS"
}

variable "storageAccountName" {
  description = "The storage account name, some limitations apply : lowercase letters and number, 3 to 24 charaters long"
  type        = "string"
  default     = "swarmclusterazureiacbga"
}

variable "storageAccountTier" {
  description = "The cluster storage account tier"
  type        = "string"
  default     = "Standard"
}

variable "storageAccountReplication" {
  description = "The cluster storage account replication type"
  type        = "string"
  default     = "LRS"
}

/**
* VM
**/

variable "ubuntuVersion" {
  description = "The Ubuntu OS version to be used on all VMs"
  type        = "string"
  default     = "18.04-LTS"
}

variable "userName" {
  description = "The username on all the VMs"
  type        = "string"
  default     = "azureuser"
}

variable "adminVmSize" {
  description = "The managers Vm Size"
  type        = "string"
  default     = "Standard_A1_v2"
}

variable "managerVmSize" {
  description = "The managers Vm Size"
  type        = "string"
  default     = "Standard_A1_v2"       # change to "Standard_DS1_v2" or more for real workload
}

variable "workerVmSize" {
  description = "The workers Vm Size"
  type        = "string"
  default     = "Standard_A1_v2"      # change to "Standard_DS1_v2" or more for real workload
}
