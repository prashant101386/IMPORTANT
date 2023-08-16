param([string] $token)

$baseUrl = "${Env:URL}"
$patToken = "${token}" 

$headers = @{
    "Authorization" = "Bearer $patToken"
    "Content-Type" = "application/json"
}

$clusterName = "learningcluster101386"
$resourceGroupName = "diff"

$body = @{
    "cluster_name" = $clusterName
}
$jsonBody = $body | ConvertTo-Json

$uri = "$baseUrl/clusters/permanent-delete"
Invoke-RestMethod -Uri $uri -Headers $headers -Method Post -Body $jsonBody
