param subscriptionId string = ''
param resourceGroupName string
param location string
param tags object
param storageAccount object
param networkSecurityGroup object
param databrick object
param routeTable object

var managedResourceGroupName = databrick.managedResourceGroupName
var trimmedMRGName = substring(managedResourceGroupName, 0, min(length(managedResourceGroupName), 90))
var managedResourceGroupId = '${subscription().id}/resourceGroups/${trimmedMRGName}'

module rg 'resource-group.bicep' = {
  name: resourceGroupName
  scope: subscription(subscriptionId) // Passing subscription scope
  params: {
    resourceGroupName: resourceGroupName
    resourceGroupLocation: location
    tags: tags
  }
}

module sa './storage-account.bicep' = {
  scope: resourceGroup(rg.name)
  name: storageAccount.name
  params: {
    storageAccount: storageAccount
    tags: tags
  }
}

module nsg './network-security-group.bicep' = if (networkSecurityGroup.enabled) {
  scope: resourceGroup(rg.name)
  name: networkSecurityGroup.name
  params: {
    networkSecurityGroup: networkSecurityGroup
    tags: tags
  }
}

module rt './route-table.bicep' = if (routeTable.enabled) {
  scope: resourceGroup(rg.name)
  name: routeTable.name
  params: {
    routeTable: routeTable
    tags: tags
  }
}

module ws './workspace.bicep' = if (databrick.enabled) {
  scope: resourceGroup(rg.name)
  name: databrick.name
  params: {
    databrick: databrick
    managedResourceGroupId: managedResourceGroupId
    tags: tags
  }
}
