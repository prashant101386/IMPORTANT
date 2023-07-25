param([string] $token)

# Replace these variables with your Databricks workspace details and access token
$workspaceBaseUrl = "https://adb-4892209284065921.1.azuredatabricks.net"
$patToken = $token
# Set the token duration in seconds (e.g., 30 days = 2592000 seconds)
$tokenLifetimeSeconds = 2592000

# Create the JSON payload
$jsonPayload = @{
    'lifetime_seconds' = $tokenLifetimeSeconds
    'comment' = "Azure PowerShell created token"
}

# Convert the JSON payload to a string
$jsonString = $jsonPayload | ConvertTo-Json

# Create the token using the Databricks API
$headers = @{
    'Authorization' = "Bearer $patToken"
    'Content-Type' = 'application/json'
}

$createTokenUrl = "$workspaceBaseUrl/api/2.0/token/create"
$response = Invoke-RestMethod -Uri $createTokenUrl -Headers $headers -Method Post -Body $jsonString

# The generated token is in the 'token_value' property of the response
$generatedToken = $response.token_value

Write-Output "Generated Token: $generatedToken"
