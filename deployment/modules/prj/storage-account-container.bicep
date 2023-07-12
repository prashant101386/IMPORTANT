param container object

resource sac 'Microsoft.Storage/storageAccounts/blobServices/containers@2022-09-01' = {
  name: 'learningsa101386/default/${container.name}'
  properties: {
    publicAccess: 'None'
  }
}
