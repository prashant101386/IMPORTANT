param dataBricks object
param managedResourceGroupId string

resource databricksWorkspace 'Microsoft.Databricks/workspaces@2023-02-01' = {
  name: dataBricks.name
  location: dataBricks.location
  sku: {
    name: dataBricks.pricingTier
  }
  properties: {
    managedResourceGroupId: managedResourceGroupId
  }
}
