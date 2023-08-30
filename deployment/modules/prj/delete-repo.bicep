param deleterepo object
param repository object
@secure()
param key string

resource removerepo 'Microsoft.Resources/deploymentScripts@2020-10-01' = {
 name: 'deletecontainer'
 location: deleterepo.location
 kind: 'AzurePowerShell'
 
 properties: {
  azPowerShellVersion: '9.7' // or azCliVersion: '2.47.0'
  scriptContent: loadTextContent('./scripts/deleterepo.ps1')
  environmentVariables: [
    {
      name: 'reponame'
      value: repository.name
    }
    {
      name: 'keys'
      secureValue: key
    }
  ]
  retentionInterval: 'PT1H'
  cleanupPreference: 'Always'
 }
}
