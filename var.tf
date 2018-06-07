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

/**
* VM
**/

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
