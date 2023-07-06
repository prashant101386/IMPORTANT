targetScope = 'subscription' // Resource group must be deployed under 'subscription' scope

param resourceGroupName string
param resourceGroupLocation string
param tags object

resource rg 'Microsoft.Resources/resourceGroups@2022-09-01' = {
  name: resourceGroupName
  location: resourceGroupLocation
  tags: tags
}
