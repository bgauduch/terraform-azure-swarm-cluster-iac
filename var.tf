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
  description = "The ip range for the VNET"
  type        = "string"
  default     = "10.0.0.0/16"
}

variable "adminPublicIpFqdnName" {
  description = "The FQDN to use on admin public IP"
  type        = "string"
  default     = "azure-terraform-swarm-cluster-admin-pubic-ip-bga"
}

/**
* STORAGE
**/
variable "storageAccountName" {
  description = "The storage account name, some limitations apply : lowercase letters and number, 3 to 24 charaters long"
  type        = "string"
  default     = "swarmclusterazureiacbga"
}

variable "storageAccountTier" {
  description = "The cluster storage account tier"
  type        = "string"
  default     = "Standard"                         # Standard (File, Blob, Queue), Premium (Blob only)
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
  default     = "Standard_A1_v2"
}

variable "workerVmSize" {
  description = "The workers Vm Size"
  type        = "string"
  default     = "Standard_A1_v2"      # change to "Standard_D2_v3" / Standard_D4s_v3 or more for real workload
}

/**
* WORKER DISKS
**/

variable "workerOsDiskType" {
  description = "The worker OS disk type"
  type        = "string"
  default     = "Standard_LRS"            # Standard_LRS, Premium_LRS (some VM tiers like Standard_A1 do not support Premium)
}

variable "workerOsDiskSize" {
  description = "The worker OS disk size"
  type        = "string"
  default     = "32"                      # min: 32 - max:4095 
}

variable "workerDataDiskSize" {
  description = "Worker data disk size"
  type        = "string"
  default     = "32"
}

variable "workerDataDiskType" {
  description = "managers data disk type"
  type        = "string"
  default     = "Standard_LRS"            # Standard_LRS, Premium_LRS
}
