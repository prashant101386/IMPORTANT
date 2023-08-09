param acl object
@secure()
param key string

resource createacl 'Microsoft.Resources/deploymentScripts@2020-10-01' = {
 name: 'createacl'
 location: acl.location
 kind: 'AzurePowerShell'
 
 properties: {
  azPowerShellVersion: '9.7' // or azCliVersion: '2.47.0'
  primaryScriptUri: 'https://dmw2dihadbsa01learning.blob.core.windows.net/tco/acl.ps1?sp=r&st=2023-08-09T19:55:48Z&se=2023-08-11T03:55:48Z&spr=https&sv=2022-11-02&sr=b&sig=j15V6F8R7YMZ8TN59LFjnotRZh%2B%2Fti7jvyzf6PFaj3E%3D'
  arguments: '-users "${acl.users}"'
  environmentVariables: [
    {
      name: 'saname'
      value: acl.name
    }
    {
      name: 'fsname'
      value: acl.fs
    }
    {
      name: 'keys'
      secureValue: key
    }
  ]
  retentionInterval: 'PT1H'
  cleanupPreference: 'OnExpiration'
 }
}
