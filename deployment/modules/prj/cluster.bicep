param cluster object
@secure()
param patToken string
param dbInstance object

resource runPowerShellInline 'Microsoft.Resources/deploymentScripts@2020-10-01' = {
  name: 'runPowerShellInline'
  location: cluster.location
  kind: 'AzurePowerShell'

  properties: {
    azPowerShellVersion: '9.7' // or azCliVersion: '2.47.0'
    /*
    scriptContent: '''
    $baseUrl = "https://adb-7867051500982459.19.azuredatabricks.net/api/2.0"
$patToken = "Bearer dapi9116d8c1b908128ce49de862b7da63e3"

$headers = @{
    "Authorization" = $patToken
    "Content-Type" = "application/json"
}

$clusterConfig = @{
    "num_workers" = 2
    "node_type_id" = "Standard_DS3_v2"
    "spark_version" = "7.3.x-scala2.12"
    "spark_conf" = @{
        "spark.executor.memory" = "4g"
        "spark.driver.memory" = "4g"
    }
}

$clusterName = "learningcluster101386"
$resourceGroupName = "diff"
$location = "centralindia"

$body = @{
    "cluster_name" = $clusterName
    "spark_version" = $clusterConfig.spark_version
    "node_type_id" = $clusterConfig.node_type_id
    "num_workers" = $clusterConfig.num_workers
    "spark_conf" = $clusterConfig.spark_conf
    "autoscale" = @{
        "min_workers" = $clusterConfig.num_workers
        "max_workers" = $clusterConfig.num_workers
    }
    "custom_tags" = @{
        "ResourceGroup" = $resourceGroupName
    }
    "spark_env_vars" = @{
        "PYSPARK_PYTHON" = "/databricks/python3/bin/python3"
    }
    "enable_elastic_disk" = "true"
    "cluster_log_conf" = @{
        "dbfs" = @{
            "destination" = "dbfs:/cluster-logs"
            "log_prefix" = "cluster-logs"
        }
    }
    "init_scripts" = @()
    "spark_conf_overlay" = @{}
}

$jsonBody = $body | ConvertTo-Json

$uri = "$baseUrl/clusters/create"

$response = Invoke-RestMethod -Uri $uri -Headers $headers -Method Post -Body $jsonBody

Write-Output $response

    '''
    */
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
