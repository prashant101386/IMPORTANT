param cluster object
param dbInstance object
@secure()
param token string

resource deletecluster 'Microsoft.Resources/deploymentScripts@2020-10-01' = if (cluster.enabled) {
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
          name: 'clustername'
          value: dbInstance.name
      }
    ]
    timeout: 'PT30M'
    cleanupPreference: 'OnExpiration'
    retentionInterval: 'PT1H'
  }
}
