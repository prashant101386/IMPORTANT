param subscriptionId string = ''
param resourceGroupName string
param location string
param tags object
param keyVault object
param iskvRequired bool

module rg 'resource-group.bicep' = {
  name: resourceGroupName
  scope: subscription(subscriptionId) // Passing subscription scope
  params: {
    resourceGroupName: resourceGroupName
    resourceGroupLocation: location
    tags: tags
  }
}

module kv 'key-vault.bicep' = if (iskvRequired == true) {
  scope: resourceGroup(rg.name)
  name: keyVault.name
  params: {
    keyVault: keyVault
    tags: tags
  }
}
