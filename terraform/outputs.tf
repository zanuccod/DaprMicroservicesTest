output "tenant_id" {
  value = azurerm_key_vault.kv.tenant_id
}

output "service_bus_connection_string" {
  description = "Connection string for the created Service Bus namespace"
  value       = azurerm_servicebus_namespace.sb.default_primary_connection_string
  sensitive   = true
}

output "service_bus_topic_name" {
  description = "Name of the created Service Bus topic"
  value       = azurerm_servicebus_topic.sb-topic.name
}