param storageAccount object
param storageAccountLocation string

resource sa 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: storageAccount.Name
  location: storageAccountLocation
  sku: storageAccount.Sku
  kind: storageAccount.Kind
}
