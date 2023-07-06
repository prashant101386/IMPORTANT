param subscriptionId string = ''
param resourceGroupName string
param location string
param storageAccount object
param ifresourceGroup bool = false

module resourcegroup 'resource-group.bicep' = {
  name: resourceGroupName
  scope: subscription(subscriptionId)
  params: {
    resourceGroupName: resourceGroupName
    resourceGroupLocation: location
  }
}

module sa 'storage-account.bicep' = if (ifresourceGroup == true) {
  name: storageAccount.name
  params: {
    storageAccount: storageAccount
    storageAccountLocation: location
  }
}

