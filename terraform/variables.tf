variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the Key Vault."
}

variable "location" {
  type        = string
  description = "The location/region where the Key Vault will be created."
}

variable "key_vault_name" {
  type        = string
  description = "The name of the Key Vault."
}

variable "key_vault_sku_name" {
  type        = string
  default     = "standard"
  description = "The name of the SKU used to purchase Key Vault. Possible values are standard and premium."
}

variable "key_vault_secret_permissions" {
  type        = list(string)
  description = "List of secret permissions."
}

variable "key_vault_secret-redis-username-key" {
  type        = string
  description = "Example key for the azure keyvault secrets"
}

variable "key_vault_secret-redis-username-value" {
  type        = string
  description = "Example key for the azure keyvault secrets"
}

variable "key_vault_secret-redis-password-key" {
  type        = string
  description = "Example key for the azure keyvault secrets"
}

variable "key_vault_secret-redis-password-value" {
  type        = string
  description = "Example key for the azure keyvault secrets"
}

variable "service_bus_sku" {
  description = "SKU (tier) of the Service Bus namespace"
  type        = string
}

variable "service_bus_namespace_name" {
  description = "Name of the Azure Service Bus namespace"
  type        = string
}

variable "service_bus_topic_name" {
  description = "Name of the Service Bus topic"
  type        = string
}

variable "service_bus_topic_max_size_in_megabytes" {
  description = "Maximum size of the Service Bus topic in megabytes"
  type        = number
}

variable "service_bus_topic_message_time_to_live" {
  description = "Default message time to live for the Service Bus topic"
  type        = string
}

variable "service_bus_topic_auto_delete_on_idle" {
  description = "(Optional) The ISO 8601 timespan duration of the idle interval after which the Topic is automatically deleted, minimum of 5 minutes."
  type        = bool
}
variable "service_bus_topic_enable_partitioning" {
  description = "Enable partitioning for the Service Bus topic"
  type        = bool
}

variable "service_bus_topic_enable_duplicate_detection" {
  description = "Enable duplicate detection for the Service Bus topic"
  type        = bool
}

variable "cosmosdb_account_name" {
  description = "Name of the Azure Cosmos DB account"
  type        = string
}

variable "mongodb_database_name" {
  description = "Name of the MongoDB database"
  type        = string
}

variable "mongodb_collection_name" {
  description = "Name of the MongoDB collection"
  type        = string
}

variable "mongodb_collection_database_name" {
  description = "Name of the Database"
  type        = string
}