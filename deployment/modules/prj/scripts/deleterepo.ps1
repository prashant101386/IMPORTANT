$accessToken = "${Env:keys}"
$username = 'prashant101386'  # Replace with your GitHub username
$repoName = "${Env:reponame}" # Replace with the repository name you want to delete

$apiUrl = "https://api.github.com/repos/$username/$repoName"

$headers = @{
    Authorization = "Bearer $accessToken"
    "User-Agent" = "PowerShell-Script"
}

$response = Invoke-RestMethod -Uri $apiUrl -Method Delete -Headers $headers

if ($response.StatusCode -eq 204) {
    Write-Host "Repository '$repoName' deleted successfully."
} else {
    Write-Host "Failed to delete repository. Status code: $($response.StatusCode)"
    Write-Host "Response: $($response | ConvertTo-Json -Depth 4)"
}
