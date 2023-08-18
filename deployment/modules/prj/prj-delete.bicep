param subscriptionId string = ''
param resourceGroupName string
param location string
param tags object
param keyVault object
param container object
param cluster object
param dbInstances array
param storageAccount object
param acl object
param deletecontainer object
param deletestoragecontainer bool

resource keyVault1 'Microsoft.KeyVault/vaults@2023-02-01' existing = {
  scope: resourceGroup('dmw2dihadbrg01-learning')
  name: 'dmw2dihadbkv01-learning2'
}

module pats 'pat.bicep' = if (cluster.enabled) {
  scope: resourceGroup('dmw2dihadbrg01-learning')
  name: 'createpat'
  params: {
    cluster: cluster
    patToken: keyVault1.getSecret('adminpat1')
  }
}

module deletecompute 'delete-cluster.bicep' = {
  scope: resourceGroup('dmw2dihadbrg01-learning')
  name: 'deletecluster'
  params: {
    cluster: cluster
    dbInstances: dbInstances
    token: pats.outputs.pat
  }
}

module removecontainer 'delete-container.bicep' = if (deletestoragecontainer) {
  scope: resourceGroup('dmw2dihadbrg01-learning')
  name: 'deletecontainer'
  params: {
    container: container
    storageaccount: storageAccount
    deletecontainer: deletecontainer
    key: keyVault1.getSecret('NEWSaKey')
  }
}
