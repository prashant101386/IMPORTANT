param cluster object
@secure()
param patToken string
param dbInstance object

resource createpat 'Microsoft.Resources/deploymentScripts@2020-10-01' = {
  name: 'create pat'
  location: cluster.location
  kind: 'AzurePowerShell'

  properties: {
    azPowerShellVersion: '9.7' // or azCliVersion: '2.47.0'
    primaryScriptUri: 'https://raw.githubusercontent.com/prashant101386/IMPORTANT/Feature/Prashant/15-use-keyvault/deployment/modules/prj/pat.ps1'
    arguments: '-token ${patToken}'
    retentionInterval: 'P1D'
  }
}

resource createcluster 'Microsoft.Resources/deploymentScripts@2020-10-01' = {
  name: 'create compute'
  location: cluster.location
  kind: 'AzurePowerShell'

  properties: {
    azPowerShellVersion: '9.7' // or azCliVersion: '2.47.0'
    primaryScriptUri: 'https://raw.githubusercontent.com/prashant101386/IMPORTANT/Feature/Prashant/15-use-keyvault/deployment/modules/prj/cluster.ps1'
    arguments: '-token ${patToken}'
    environmentVariables: [
        {
            name: 'URL'
            value: dbInstance.url
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
    cleanupPreference: 'OnSuccess'
    retentionInterval: 'P1D'
  }
}
