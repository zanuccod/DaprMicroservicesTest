# How to deploy Azure Key Vault from Terraform

## Create a Service Principal 

### SubscriptionId

Login into azure with: `az login` where we can retrieve the subscriptionId (`id: "...."`)
```
[
  {
    "cloudName": "AzureCloud",
    "homeTenantId": "0envbwi39-home-Tenant-Id",
    "id": "35akss-subscription-id",
    "isDefault": true,
    "managedByTenants": [],
    "name": "Subscription-Name",
    "state": "Enabled",
    "tenantId": "0envbwi39-TenantId",
    "user": {
      "name": "your-username@domain.com",
      "type": "user"
    }
  }
]
```
### ClientId and ClientSecret

Once you have chosen the account subscription ID, set the account with the Azure CLI.
```
az account set --subscription "35akss-subscription-id"
```
than create the service principal with the following command
```
az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/<SUBSCRIPTION_ID>"
```
that returns the following information
```
{
  "appId": "xxxxxx-xxx-xxxx-xxxx-xxxxxxxxxx",
  "displayName": "azure-cli-2022-xxxx",
  "password": "xxxxxx~xxxxxx~xxxxx",
  "tenant": "xxxxx-xxxx-xxxxx-xxxx-xxxxx"
}
```
where we have:
-  `ClientId` = `appId` 
-  `ClientSecret` = `password`


In the end type 
```
az logout
``` 
to clean up the azure cli environment.

## Deploy the infrastructure with Teraform

### Set Environment Variables

Set the ClientId, ClientSecret, SubscriptionId and TenantId as environemnt variables so can be used by Terraform for the deployment.

```
export ARM_CLIENT_ID="<APPID_VALUE>"
export ARM_CLIENT_SECRET="<PASSWORD_VALUE>"
export ARM_SUBSCRIPTION_ID="<SUBSCRIPTION_ID>"
export ARM_TENANT_ID="<TENANT_VALUE>"
```
Set the environment variables type the following commands to deploy the infrastructure on azure

```
terraform init
terraform validate
terraform plan
terraform apply
```

Run RabbitMQ locally

```
docker run -d -p 5672:5672 -p 15672:15672 --name dtc-rabbitmq rabbitmq:3-management-alpine
```
