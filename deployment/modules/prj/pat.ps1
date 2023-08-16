param([string] $token)

# Replace these variables with your Databricks workspace details and access token
$workspaceBaseUrl = "https://adb-6384764012615846.6.azuredatabricks.net"
$patToken = $token
# Set the token duration in seconds (e.g., 30 days = 2592000 seconds)
$tokenLifetimeSeconds = 2592000

# Create the JSON payload
$jsonPayload = @{
    'lifetime_seconds' = $tokenLifetimeSeconds
    'comment' = "Azure PowerShell automatic token"
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

$DeploymentScriptOutputs = @{}
$DeploymentScriptOutputs['autotoken'] = $response.token_value
