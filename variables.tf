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

variable "clusterResourceGroupName" {
  description = "the resource group name"
  type        = "string"
  default     = "swarm-cluster-resourcegroup"
}

variable "agResourceGroupName" {
  description = "the resource group name"
  type        = "string"
  default     = "ag-resourcegroup"
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
  description = "The cluster storage account tier, can be either 'Standard' (File, Blob, Queue) or 'Premium' (Blob only)"
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
variable "updateDomainCount" {
  description = "The number of UPDATE domains to be used on all availability sets"
  type        = "string"
  default     = "3"
}

variable "faultDomainCount" {
  description = "The number of FAULT domains to be used on all availability sets, check the Azure Region compatibility list: https://github.com/MicrosoftDocs/azure-docs/blob/master/includes/managed-disks-common-fault-domain-region-list.md"
  type        = "string"
  default     = "3"
}

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
  description = "The workers Vm Size, should be set to a decent sizing for real world workload (ie: Standard_D2_v3 / Standard_DS3_v2 / Standard_D4s_v3 / ..."
  type        = "string"
  default     = "Standard_A1_v2"
}

/**
* DISKS
**/

variable "workerOsDiskType" {
  description = "The worker OS disk type, can be either 'Standard_LRS' or 'Premium_LRS' (note that some VM tiers like Standard_A1 do not support Premium)"
  type        = "string"
  default     = "Standard_LRS"
}

variable "workerOsDiskSize" {
  description = "The worker OS disk size, must be between min=32 and max=4095"
  type        = "string"
  default     = "32"
}

variable "workerDataDiskSize" {
  description = "Worker data disk size"
  type        = "string"
  default     = "32"
}

variable "workerDataDiskType" {
  description = "Managers data disk type, can be either 'Standard_LRS' or 'Premium_LRS'"
  type        = "string"
  default     = "Standard_LRS"
}

/**
* AG
**/
variable "agApplicationDomainName" {
  description = "The public FQDN used to aces the application on the internet"
  type = "string"
}
variable "agSku" {
  description = "The Application Gateway tiers, can be one of the following : 'Standard_Small', 'Standard_Medium', 'Standard_Large', 'WAF_Medium', 'WAF_Large'"
  type        = "string"
  default     = "Standard_Small"
}

variable "agTier" {
  description = "The Application Gateway tiers, can be either 'Standard' or 'WAF'. The AG SKU need to be one of 'WAF' type to allow WAF tier"
  type        = "string"
  default     = "Standard"
}

variable "agInstanceCount" {
  description = "The Application Gateway instance capacity, can be between min=1 to max=10"
  type        = "string"
  default     = "1"
}

variable "agPublicIpFqdnName" {
  description = "The Application Gateway public IP FQDN"
  type        = "string"
  default     = "azure-terraform-swarm-cluster-ag-pubic-ip"
}

/**
* MySQL DATABASE
**/
variable "mysqlServerSkuName" {
  description = "The SKU name of the MySQL server, folow the 'tier + family + cores' pattern."
  type        = "string"
  default     = "GP_Gen5_2"                                                                    # here : general purpose, Gen5, 2 vCore
}

variable "mysqlServerSkuCapacity" {
  description = "The scale up/out capacity, representing server's compute units"
  type        = "string"
  default     = "2"
}

variable "mysqlServerSkuTier" {
  description = "The tier of the particular SKU. Possible values are Basic, GeneralPurpose, and MemoryOptimized. See https://docs.microsoft.com/en-us/azure/mysql/concepts-pricing-tiers"
  type        = "string"
  default     = "GeneralPurpose"
}

variable "mysqlServerSkuFamily" {
  description = "The family of hardware Gen4 or Gen5"
  type        = "string"
  default     = "Gen5"
}

variable "mysqlServerAdminLogin" {
  description = "The admin login to be use on the MySQL server"
  type        = "string"
  default     = "mysqladmin"
}

variable "mysqlServerAdminPassword" {
  description = "The admin login to be use on the MySQL server"
  type        = "string"
}

variable "mysqlDatabaseName" {
  description = "The MySQL database name to be created on the MySQL server"
  type        = "string"
  default     = "defaultdb"
}

variable "mysqlGeoredundantBackup" {
  description = "Activate or not the geographic redundancy of the MySQL server backups"
  type        = "string"
  default     = "Disabled"
}

variable "mysqlEnforceSSL" {
  description = "Set whether SSL should be enforced or not on the MySQL server"
  type        = "string"
  default     = "Enabled"
}

variable "mysqlStorageSize" {
  description = "Set the max storage size of the MySQL server"
  type        = "string"
  default     = "5120"                                         # 5120 MB = 5 GB, 102400 MB = 100 GB
}

variable "mysqlBackupRetentionDays" {
  description = "Number of day to retain point-in-time backups of database on the MySQL server"
  type        = "string"
  default     = "7"
}

/**
* REDIS CACHE
**/

variable "redisSkuName" {
  description = "The SKU of Redis to use - can be either Basic, Standard or Premium"
  type        = "string"
  default     = "Basic"
}

variable "redisSkuFamily" {
  description = "The SKU family to use. Valid values are C and P, where C = Basic/Standard, P = Premium"
  type        = "string"
  default     = "C"
}

variable "redisCapacity" {
  description = "The size of the Redis cache to deploy. Valid values for a SKU family of C (Basic/Standard) are 0, 1, 2, 3, 4, 5, 6, and for P (Premium) family are 1, 2, 3, 4"
  type        = "string"
  default     = "1"
}
