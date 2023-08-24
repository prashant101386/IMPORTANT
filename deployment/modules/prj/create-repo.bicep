param repository object
@secure()
param key string

resource createrepo 'Microsoft.Resources/deploymentScripts@2020-10-01' = {
  name: repository.name
  location: repository.location
  kind: 'AzurePowerShell'

  properties: {
    azPowerShellVersion: '9.7'
    scriptContent: loadTextContent('./scripts/repository.ps1')
    environmentVariables: [
      {
        name: 'reponame'
        value: repository.name
      }
      {
        name: 'keys'
        value: key
      }
    ]
  timeout: 'PT30M'
  cleanupPreference: 'Always'
  retentionInterval: 'PT1H'
  }
}
