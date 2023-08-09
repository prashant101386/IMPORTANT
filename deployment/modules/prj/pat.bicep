param cluster object
@secure()
param patToken string

resource createpat 'Microsoft.Resources/deploymentScripts@2020-10-01' = if (cluster.enabled) {
  name: 'createpat'
  location: cluster.location
  kind: 'AzurePowerShell'

  properties: {
    azPowerShellVersion: '9.7' // or azCliVersion: '2.47.0'
    primaryScriptUri: 'https://dmw2dihadbsa01learning.blob.core.windows.net/tco/pat.ps1'
    arguments: '-token ${patToken}'
    cleanupPreference: 'OnExpiration'
    retentionInterval: 'PT1H'
  }
}

output pat string = (cluster.enabled) ? '${createpat.properties.outputs.autotoken}':''
