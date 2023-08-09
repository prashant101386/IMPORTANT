param cluster object
param dbInstance object
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
resource createcluster 'Microsoft.Resources/deploymentScripts@2020-10-01' = if (cluster.enabled) {
  name: 'createcompute'
  location: cluster.location
  kind: 'AzurePowerShell'

  properties: {
    azPowerShellVersion: '9.7' // or azCliVersion: '2.47.0'
    primaryScriptUri: 'https://dmw2dihadbsa01learning.blob.core.windows.net/tco/cluster.ps1?sp=r&st=2023-08-09T20:02:11Z&se=2023-08-11T04:02:11Z&spr=https&sv=2022-11-02&sr=b&sig=PisJYdGOKbbQzhhVc%2FxNZhvT8XYQ3KHhv%2FEY6kXaMcE%3D'
    arguments: '-token ${token}'
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
    cleanupPreference: 'OnExpiration'
    retentionInterval: 'PT1H'
  }
}
