variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the Key Vault."
  default     = "dapr-architecture-test"
}

variable "location" {
  type        = string
  description = "The location/region where the Key Vault will be created."
  default     = "switzerlandnorth"
}

variable "key_vault_name" {
  type        = string
  description = "The name of the Key Vault."
  default     = "daprkvricopegnata"
}

variable "key_vault_sku_name" {
  type        = string
  default     = "standard"
  description = "The name of the SKU used to purchase Key Vault. Possible values are standard and premium."
}

variable "key_vault_secret_permissions" {
  type        = list(string)
  description = "List of secret permissions."
  default     = ["Delete", "Purge", "Recover", "Get", "List", "Set"]
}

variable "key_vault_secret-redis-username-key" {
  type        = string
  description = "Example key for the azure keyvault secrets"
  default     = "RedisUsername"
}

variable "key_vault_secret-redis-username-value" {
  type        = string
  description = "Example key for the azure keyvault secrets"
  default     = "RedisUsername_KeyVault"
}

variable "key_vault_secret-redis-password-key" {
  type        = string
  description = "Example key for the azure keyvault secrets"
  default     = "RedisPassword"
}

variable "key_vault_secret-redis-password-value" {
  type        = string
  description = "Example key for the azure keyvault secrets"
  default     = "RedisPassword_KeyVault"
}

variable "key_vault_secret-redis-instance-key" {
  type        = string
  description = "Example key for the azure keyvault secrets"
  default     = "RedisInstance"
}

variable "key_vault_secret-redis-instance-value" {
  type        = string
  description = "Example key for the azure keyvault secrets"
  default     = "false"
}

variable "service_bus_sku" {
  description = "SKU (tier) of the Service Bus namespace"
  type        = string
  default     = "Standard"
}

variable "service_bus_namespace_name" {
  description = "Name of the Azure Service Bus namespace"
  type        = string
  default     = "daprsbricopegnata"
}

variable "service_bus_topic_name" {
  description = "Name of the Service Bus topic"
  type        = string
  default     = "dapr_test_topic"
}

variable "service_bus_topic_max_size_in_megabytes" {
  description = "Maximum size of the Service Bus topic in megabytes"
  type        = number
  default     = 1024 # 1 GB
}

variable "service_bus_topic_message_time_to_live" {
  description = "Default message time to live for the Service Bus topic"
  type        = string
  default     = "PT1M" # 1 minute
}

variable "service_bus_topic_auto_delete_on_idle" {
  description = "(Optional) The ISO 8601 timespan duration of the idle interval after which the Topic is automatically deleted, minimum of 5 minutes."
  type        = bool
  default     = true
}
variable "service_bus_topic_enable_partitioning" {
  description = "Enable partitioning for the Service Bus topic"
  type        = bool
  default     = false
}

variable "service_bus_topic_enable_duplicate_detection" {
  description = "Enable duplicate detection for the Service Bus topic"
  type        = bool
  default     = true
}