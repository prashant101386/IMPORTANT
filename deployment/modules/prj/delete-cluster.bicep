param cluster object
param dbInstances array
@secure()
param token string

resource deletecluster 'Microsoft.Resources/deploymentScripts@2020-10-01' = [for dbInstance in dbInstances: {
  name: 'deletecompute${uniqueString(dbInstance.name)}'
  location: cluster.location
  kind: 'AzurePowerShell'

  properties: {
    azPowerShellVersion: '9.7' // or azCliVersion: '2.47.0'
    scriptContent: loadTextContent('./scripts/deleteCluster.ps1')
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
]
