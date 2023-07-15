param subscriptionId string = ''
param resourceGroupName string
param location string
param tags object
param keyVault object
param container object
//param dataBricks object
param cluster object

//var managedResourceGroupName = dataBricks.managedResourceGroupName
//var trimmedMRGName = substring(managedResourceGroupName, 0, min(length(managedResourceGroupName), 90))
//var managedResourceGroupId = '${subscription().id}/resourceGroups/${trimmedMRGName}'

module rg 'resource-group.bicep' = {
  name: resourceGroupName
  scope: subscription(subscriptionId) // Passing subscription scope
  params: {
    resourceGroupName: resourceGroupName
    resourceGroupLocation: location
    tags: tags
  }
}

module kv 'key-vault.bicep' = {
  scope: resourceGroup(rg.name)
  name: keyVault.name
  params: {
    keyVault: keyVault
    tags: tags
  }
}

module sac 'storage-account-container.bicep' = {
  scope: resourceGroup('diff')
  name: container.name
  params: {
    container: container
  }
}
/*
module adb 'dataBricks.bicep' = {
  scope: resourceGroup('diff')
  name: dataBricks.name
  params: {
    dataBricks: dataBricks
    managedResourceGroupId: managedResourceGroupId
  }
}
*/

module compute 'cluster.bicep' = {
  scope: resourceGroup('diff')
  name: 'createcontainer'
  params: {
    cluster: cluster
  }
}
