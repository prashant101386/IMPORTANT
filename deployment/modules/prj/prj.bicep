param subscriptionId string = 'e609b895-8521-4e27-a166-510b517292f5'
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
param repository object
param deleterepository bool
param deleterepo object


module rg 'resource-group.bicep' = {
  name: resourceGroupName
  scope: subscription(subscriptionId) // Passing subscription scope
  params: {
    resourceGroupName: resourceGroupName
    resourceGroupLocation: location
    tags: tags
  }
}

module kv 'key-vault.bicep' = {
  scope: resourceGroup(rg.name)
  name: keyVault.name
  params: {
    keyVault: keyVault
    tags: tags
  }
}

module sac 'storage-account-container.bicep' = if (container.enabled) {
  scope: resourceGroup('dmw2dihadbrg01-learning')
  name: container.name
  params: {
    container: container
    storageAccount: storageAccount
  }
}

resource keyVault1 'Microsoft.KeyVault/vaults@2023-02-01' existing = {
  scope: resourceGroup('dmw2dihadbrg01-learning')
  name: 'dmw2dihadbkv01-learning2'
}

module acls 'container-acl.bicep' = {
  scope: resourceGroup('dmw2dihadbrg01-learning')
  name: 'createacl'
  params: {
    acl:acl
    key: keyVault1.getSecret('NEWSaKey')
  }
}

module pats 'pat.bicep' = if (cluster.enabled) {
  scope: resourceGroup('dmw2dihadbrg01-learning')
  name: 'createpat'
  params: {
    cluster: cluster
    patToken: keyVault1.getSecret('adminpat1')
  }
}

module compute 'cluster.bicep' = if (cluster.enabled) {
  scope: resourceGroup('dmw2dihadbrg01-learning')
  name: 'createcluster'
  params: {
    cluster: cluster
    dbInstances: dbInstances
    token: pats.outputs.pat
  }
}

module repo 'create-repo.bicep' = if (repository.enabled) {
  name: repository.name
  params: {
    repository:repository
    key: keyVault1.getSecret('githubtoken')
  }
}

//Test Issue 2
//Test-issue1

