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
  default     = "daprkvricopegnate"
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

