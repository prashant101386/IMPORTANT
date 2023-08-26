param deletecontainer object
param storageaccount object
param container object
@secure()
param key string

resource removecontainer 'Microsoft.Resources/deploymentScripts@2020-10-01' = {
 name: 'deletecontainer'
 location: deletecontainer.location
 kind: 'AzurePowerShell'
 
 properties: {
  azPowerShellVersion: '9.7' // or azCliVersion: '2.47.0'
  scriptContent: loadTextContent('./scripts/deletecontainer.ps1')
  environmentVariables: [
    {
      name: 'saname'
      value: storageaccount.name
    }
    {
      name: 'fsname'
      value: container.name
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
