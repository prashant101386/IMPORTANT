param resourceGroupName string
param principals array
param storageAccountName string

resource rg 'Microsoft.Resources/resourceGroups@2021-01-01' existing = {
  scope: subscription()
  name: resourceGroupName
}

resource rgRoles 'Microsoft.Authorization/roleAssignments@2022-04-01' = [for principal in principals: if (contains(principal.type, 'resourceGroup')) {
  name: guid(rg.name, principal.principalId, principal.roleDefinitionId)
  properties: {
    principalId: principal.principalId
    roleDefinitionId: resourceId('Microsoft.Authorization/roleDefinitions', principal.roleDefinitionId)
    principalType: principal.principalType
  }
}]

resource sa 'Microsoft.ContainerRegistry/registries@2023-01-01-preview' existing = {
  name: storageAccountName
}
resource acrRoles 'Microsoft.Authorization/roleAssignments@2022-04-01' = [for principal in principals: if (contains(principal.type, 'acr')) {
  name: guid(sa.name, principal.principalId, principal.roleDefinitionId)
  scope: sa
  properties: {
    principalId: principal.principalId
    roleDefinitionId: resourceId('Microsoft.Authorization/roleDefinitions', principal.roleDefinitionId)
    principalType: principal.principalType
  }
}]
