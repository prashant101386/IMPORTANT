targetScope = 'subscription'

param resourceGroupName string
param resourceGroupLocation string

resource rg 'Microsoft.Resources/resourceGroups@2022-09-01' = {
  name: resourceGroupName
  location: resourceGroupLocation
}
