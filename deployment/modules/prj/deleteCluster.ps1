param([string] $token)

$baseUrl = "${Env:URL}"
$patToken = "${token}" 

$headers = @{
    "Authorization" = "Bearer $patToken"
    "Content-Type" = "application/json"
}

$clusterId = "0816-160959-ya4b8twc"
$resourceGroupName = "diff"

$body = @{
    "cluster_id" = $clusterId
}
$jsonBody = $body | ConvertTo-Json

$uri = "$baseUrl/clusters/permanent-delete"
Invoke-RestMethod -Uri $uri -Headers $headers -Method Post -Body $jsonBody
