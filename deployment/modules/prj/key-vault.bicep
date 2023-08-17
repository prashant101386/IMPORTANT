param keyVault object
param tags object

resource kv 'Microsoft.KeyVault/vaults@2023-02-01' = if (keyVault.isRequired == false) {
  name: keyVault.name
  location: keyVault.location
  tags: tags
  properties: {
    sku: keyVault.sku
    tenantId: keyVault.tenantId
    accessPolicies: keyVault.accessPolicies
    enabledForDeployment: false
    enabledForDiskEncryption: false
    enabledForTemplateDeployment: false
    enableSoftDelete: true
    softDeleteRetentionInDays: 90
    enableRbacAuthorization: false
    publicNetworkAccess: 'Enabled'
    enablePurgeProtection: true
  }
}
