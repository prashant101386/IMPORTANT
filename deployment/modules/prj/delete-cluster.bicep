param cluster object
param dbInstance object
@secure()
param token string

resource createcluster 'Microsoft.Resources/deploymentScripts@2020-10-01' = if (cluster.enabled) {
  name: 'deletecompute'
  location: cluster.location
  kind: 'AzurePowerShell'

  properties: {
    azPowerShellVersion: '9.7' // or azCliVersion: '2.47.0'
    scriptContent: loadTextContent('deleteCluster.ps1')
    arguments: '-token ${token}'
    environmentVariables: [
      {
          name: 'URL'
          value: dbInstance.url
      }
      {
          name: 'numofworker'
          value: dbInstance.num
      }
    ]
    timeout: 'PT30M'
    cleanupPreference: 'OnExpiration'
    retentionInterval: 'PT1H'
  }
}