param container object
param storageAccount object

resource sac 'Microsoft.Storage/storageAccounts/blobServices/containers@2022-09-01' = {
  name: '${storageAccount.name}/default/${container.name}'
  properties: {
    publicAccess: 'None'
  }
}
