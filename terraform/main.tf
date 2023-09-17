terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.70.0"
    }
  }
  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}

data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_key_vault" "kv" {
  name                = var.key_vault_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = var.key_vault_sku_name
  depends_on          = [azurerm_resource_group.rg]

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    secret_permissions = var.key_vault_secret_permissions
  }
}

resource "azurerm_key_vault_secret" "kv-redisuser-key" {
  key_vault_id = azurerm_key_vault.kv.id
  name         = var.key_vault_secret-redis-username-key
  value        = var.key_vault_secret-redis-username-value
  depends_on   = [azurerm_key_vault.kv]
}

resource "azurerm_key_vault_secret" "kv-redispassword-key" {
  key_vault_id = azurerm_key_vault.kv.id
  name         = var.key_vault_secret-redis-password-key
  value        = var.key_vault_secret-redis-password-value
  depends_on   = [azurerm_key_vault.kv]
}

resource "azurerm_key_vault_secret" "kv-redisinstance-key" {
  key_vault_id = azurerm_key_vault.kv.id
  name         = var.key_vault_secret-redis-instance-key
  value        = var.key_vault_secret-redis-instance-value
  depends_on   = [azurerm_key_vault.kv]
}

resource "azurerm_servicebus_namespace" "sb" {
  name                = var.service_bus_namespace_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.service_bus_sku
  depends_on          = [azurerm_resource_group.rg]
}

resource "azurerm_servicebus_topic" "sb-topic" {
  namespace_id = azurerm_servicebus_namespace.sb.id
  name         = var.service_bus_topic_name

  max_size_in_megabytes = var.service_bus_topic_max_size_in_megabytes
  default_message_ttl   = var.service_bus_topic_message_time_to_live

  requires_duplicate_detection = var.service_bus_topic_enable_duplicate_detection
  enable_partitioning          = var.service_bus_topic_enable_partitioning

  depends_on = [azurerm_servicebus_namespace.sb]
}

resource "azurerm_servicebus_topic_authorization_rule" "sb-topic-sap" {
  name     = "dapr-test-shared-access-policy"
  topic_id = azurerm_servicebus_topic.sb-topic.id

  listen = true
  send   = true
  manage = true
}