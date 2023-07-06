
param storageAccount object
param tags object

resource symbolicname 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: storageAccount.name
  location: storageAccount.location
  tags: tags
  sku: {
    name: storageAccount.sku
  }
  kind: 'StorageV2'
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    accessTier: 'Hot'
    allowBlobPublicAccess: true
    isHnsEnabled: true
    minimumTlsVersion: 'TLS1_2'
    publicNetworkAccess: 'Enabled'
    supportsHttpsTrafficOnly: true
  }
}
