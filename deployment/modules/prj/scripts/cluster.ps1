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

$clusterName = "${Env:clustername}"
$resourceGroupName = "diff"

$body = @{
    "cluster_name" = $clusterName
    "spark_version" = $clusterConfig.spark_version
    "node_type_id" = $clusterConfig.node_type_id
    "num_workers" = $clusterConfig.num_workers
    "spark_conf" = $clusterConfig.spark_conf
}

# Construct the API URL to list all clusters
$apiUrl = "$baseUrl/clusters/list"

$response = Invoke-WebRequest -Uri $apiUrl -Headers @{ Authorization = "Bearer $patToken" }

# Convert the JSON response to a PowerShell object
$clusterList = $response.Content | ConvertFrom-Json

# Find the cluster ID for the provided cluster name
$retrievedCluster = $clusterList.clusters | Where-Object { $_.cluster_name -eq $clusterName }

# Check if the cluster was found and display the cluster ID
if ($retrievedCluster) {
    $retrievedClusterId = $retrievedCluster.cluster_id
    Write-Host "Retrieved Cluster ID: $retrievedClusterId"
    Exit
} else {
    $jsonBody = $body | ConvertTo-Json

    $uri = "$baseUrl/clusters/create"
    
    Invoke-RestMethod -Uri $uri -Headers $headers -Method Post -Body $jsonBody
}