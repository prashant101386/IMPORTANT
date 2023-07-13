param container object

resource sac 'Microsoft.Storage/storageAccounts/blobServices/containers@2022-09-01' = if (container.isRequired == true) {
  name: 'learningsa101386/default/${container.name}'
  properties: {
    publicAccess: 'None'
  }
}
