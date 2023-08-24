param cluster object
param dbInstances array
@secure()
param token string
/*
resource createpat 'Microsoft.Resources/deploymentScripts@2020-10-01' = {
  name: 'createpat'
  location: cluster.location
  kind: 'AzurePowerShell'

  properties: {
    azPowerShellVersion: '9.7' // or azCliVersion: '2.47.0'
    primaryScriptUri: 'https://raw.githubusercontent.com/prashant101386/IMPORTANT/Feature/Prashant/15-use-keyvault/deployment/modules/prj/pat.ps1'
    arguments: '-token ${patToken}'
    retentionInterval: 'P1D'
  }
}
*/
resource createcluster 'Microsoft.Resources/deploymentScripts@2020-10-01' = [for dbInstance in dbInstances: {
  name: 'createcompute${uniqueString(dbInstance.name)}'
  location: cluster.location
  kind: 'AzurePowerShell'

  properties: {
    azPowerShellVersion: '9.7' // or azCliVersion: '2.47.0'
    scriptContent: loadTextContent('./scripts/cluster.ps1')
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
        {
            name: 'numofworker'
            value: dbInstance.num
        }
        {
            name: 'nodetype'
            value: dbInstance.nodetype
        }
        {
            name: 'sparkversion'
            value: dbInstance.sparkversion
        }
        {
            name: 'executormemory'
            value: dbInstance.executormemory
        }
        {
            name: 'drivermemory'
            value: dbInstance.drivermemory
        }
    ]
    timeout: 'PT30M'
    cleanupPreference: 'Always'
    retentionInterval: 'PT1H'
  }
}
]
