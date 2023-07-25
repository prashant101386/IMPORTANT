param([string] $token)

$baseUrl = "${Env:URL}"
$numworker = "${Env:numofworker}"
$type = "${Env:nodetype}"
$patToken = "${token}" 
$sparkversion = "${Env:sparkversion}"
$executormemory = "${Env:executormemory}"
$drivermemory = "${Env:drivermemory}"

$headers = @{
    "Authorization" = "Bearer $patToken"
    "Content-Type" = "application/json"
}

$clusterConfig = @{
    "num_workers" = $numworker
    "node_type_id" = "$type"
    "spark_version" = "$sparkversion"
    "spark_conf" = @{
        "spark.executor.memory" = "$executormemory"
        "spark.driver.memory" = "$drivermemory"
    }
}

$clusterName = "learningcluster101386"
$resourceGroupName = "diff"

$body = @{
    "cluster_name" = $clusterName
    "spark_version" = $clusterConfig.spark_version
    "node_type_id" = $clusterConfig.node_type_id
    "num_workers" = $clusterConfig.num_workers
    "spark_conf" = $clusterConfig.spark_conf
}

$jsonBody = $body | ConvertTo-Json

$uri = "$baseUrl/clusters/create"

Invoke-RestMethod -Uri $uri -Headers $headers -Method Post -Body $jsonBody