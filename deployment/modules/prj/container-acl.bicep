param acl object
@secure()
param key string

resource createacl 'Microsoft.Resources/deploymentScripts@2020-10-01' = {
 name: 'createacl'
 location: acl.location
 kind: 'AzurePowerShell'
 
 properties: {
  azPowerShellVersion: '9.7' // or azCliVersion: '2.47.0'
  primaryScriptUri: 'https://raw.githubusercontent.com/prashant101386/IMPORTANT/main/deployment/modules/prj/acl.ps1'
  arguments: '-keys ${key}'
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
      name: 'user1'
      value: acl.user1
    }
    {
      name: 'user2'
      value: acl.user2
    }
  ]
  retentionInterval: 'PT1H'
  cleanupPreference: 'OnSuccess'
 }
}
