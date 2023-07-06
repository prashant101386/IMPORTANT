param subscriptionId string = ''
param resourceGroupName string
param principals array
param storageAccountName string

module rg './resource-group.bicep' = {
  name: resourceGroupName
  scope: subscription(subscriptionId) // Passing subscription scope
  params: {
    resourceGroupName: resourceGroupName
  }
}

module roleAssignments './resource-roles.bicep' = {
  name: resourceGroupName
  params: {
    principals: principals
    resourceGroupName: resourceGroupName
    storageAccountName: storageAccountName
  }
}
