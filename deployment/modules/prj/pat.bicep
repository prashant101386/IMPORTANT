param cluster object
@secure()
param patToken string

resource createpat 'Microsoft.Resources/deploymentScripts@2020-10-01' = if (cluster.enabled) {
  name: 'createpat'
  location: cluster.location
  kind: 'AzurePowerShell'

  properties: {
    azPowerShellVersion: '9.7' // or azCliVersion: '2.47.0'
    primaryScriptUri: 'https://dmw2dihadbsa01learning.blob.core.windows.net/tco/pat.ps1?sp=r&st=2023-08-09T20:02:38Z&se=2023-08-11T04:02:38Z&spr=https&sv=2022-11-02&sr=b&sig=pV2T5u0lRL52NGFC1Q0cpJwPrk6vfIYY986C1kVACRU%3D'
    arguments: '-token ${patToken}'
    cleanupPreference: 'OnExpiration'
    retentionInterval: 'PT1H'
  }
}

output pat string = (cluster.enabled) ? '${createpat.properties.outputs.autotoken}':''
