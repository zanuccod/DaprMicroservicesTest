resource_group_name = "dapr-architecture-test"
location            = "switzerlandnorth"

# Key Vault
key_vault_name               = "daprkvricopegnata"
key_vault_secret_permissions = ["Delete", "Purge", "Recover", "Get", "List", "Set"]

# Key Vaul Keys
key_vault_secret-redis-username-key   = "RedisUsername"
key_vault_secret-redis-username-value = "RedisUsername_KeyVault"

key_vault_secret-redis-password-key   = "RedisPassword"
key_vault_secret-redis-password-value = "RedisPassword_KeyVault"

# Service Bus
service_bus_sku                              = "Standard"
service_bus_namespace_name                   = "daprsbricopegnata"
service_bus_topic_name                       = "dapr_test_topic"
service_bus_topic_max_size_in_megabytes      = 1024   # 1 GB
service_bus_topic_message_time_to_live       = "PT1M" # 1 minute
service_bus_topic_auto_delete_on_idle        = true
service_bus_topic_enable_partitioning        = false
service_bus_topic_enable_duplicate_detection = true

# Cosmos DB
cosmosdb_account_name            = "daprcosmosdb"
mongodb_database_name            = "daprmongodb"
mongodb_collection_name          = "daprcollection"
mongodb_collection_database_name = "daprdatabase"