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
  arguments: '-key ${key}'
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
      name: 'user'
      value: acl.users
    }
  ]
  retentionInterval: 'PT1H'
 }
}