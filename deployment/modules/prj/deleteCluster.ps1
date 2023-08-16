param([string] $token)

$baseUrl = "${Env:URL}"
$patToken = "${token}" 

$headers = @{
    "Authorization" = "Bearer $patToken"
    "Content-Type" = "application/json"
}

# Set other variables
$clusterName = "${Env:clustername}" # Replace with the actual cluster name

# Construct the API URL to list all clusters
$apiUrl = "$baseUrl/clusters/list"

# Invoke the API request
$response = Invoke-WebRequest -Uri $apiUrl -Headers @{ Authorization = "Bearer $token" }

# Convert the JSON response to a PowerShell object
$clusterList = $response.Content | ConvertFrom-Json

# Find the cluster ID for the provided cluster name
$retrievedCluster = $clusterList.clusters | Where-Object { $_.cluster_name -eq $clusterName }

# Check if the cluster was found and display the cluster ID
if ($retrievedCluster) {
    $retrievedClusterId = $retrievedCluster.cluster_id
    Write-Host "Retrieved Cluster ID: $retrievedClusterId"
} else {
    Write-Host "Cluster with name '$clusterName' not found."
}

$body = @{
    "cluster_id" = $retrievedClusterId
}
$jsonBody = $body | ConvertTo-Json

$uri = "$baseUrl/clusters/permanent-delete"
Invoke-RestMethod -Uri $uri -Headers $headers -Method Post -Body $jsonBody
