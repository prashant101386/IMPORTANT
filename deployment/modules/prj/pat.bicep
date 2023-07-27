param cluster object
@secure()
param patToken string

resource createpat 'Microsoft.Resources/deploymentScripts@2020-10-01' = {
  name: 'createpat'
  location: cluster.location
  kind: 'AzurePowerShell'

  properties: {
    azPowerShellVersion: '9.7' // or azCliVersion: '2.47.0'
    primaryScriptUri: 'https://raw.githubusercontent.com/prashant101386/IMPORTANT/Feature/Prashant/15-use-keyvault/deployment/modules/prj/pat.ps1'
    arguments: '-token ${patToken}'
    cleanupPreference: 'OnExpiration'
    retentionInterval: 'PT1H'
  }
}

output pat string = '${createpat.properties.outputs.autotoken}'
