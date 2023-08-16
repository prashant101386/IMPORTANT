param cluster object
param dbInstance object

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

module deletecompute 'delete-cluster.bicep' = if (cluster.enabled) {
  scope: resourceGroup('dmw2dihadbrg01-learning')
  name: 'deletecluster'
  params: {
    cluster: cluster
    dbInstance: dbInstance
    token: pats.outputs.pat
  }
}
