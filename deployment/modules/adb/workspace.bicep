param databrick object
param managedResourceGroupId string
param tags object

resource workspace 'Microsoft.Databricks/workspaces@2023-02-01' = {
  name: databrick.name
  location: databrick.location
  tags: tags
  sku: {
    name: databrick.pricingTier
  }
  properties: {
    managedResourceGroupId: managedResourceGroupId
  }
}
