param([string] $token)

$baseUrl = "${Env:URL}"
$patToken = "${token}" 

$headers = @{
    "Authorization" = "Bearer $patToken"
    "Content-Type" = "application/json"
}
$ClusterName = "learningcluster101386"
$Cluster = Get-DatabricksClusters -Bearer $patToken -Region "centralindia" | Where-Object {$_.cluster_name -eq $ClusterName}

$clusterId = $Cluster.cluster_id

$body = @{
    "cluster_id" = $clusterId
}
$jsonBody = $body | ConvertTo-Json

$uri = "$baseUrl/clusters/permanent-delete"
Invoke-RestMethod -Uri $uri -Headers $headers -Method Post -Body $jsonBody
