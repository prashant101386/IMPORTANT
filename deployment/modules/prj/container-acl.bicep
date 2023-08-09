param acl object
@secure()
param key string

resource createacl 'Microsoft.Resources/deploymentScripts@2020-10-01' = {
 name: 'createacl'
 location: acl.location
 kind: 'AzurePowerShell'
 
 properties: {
  azPowerShellVersion: '9.7' // or azCliVersion: '2.47.0'
  primaryScriptUri: 'https://raw.githubusercontent.com/prashant101386/IMPORTANT/Feature/Prashant/23-try-different-user-permission-pair/deployment/modules/prj/acl.ps1'
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
