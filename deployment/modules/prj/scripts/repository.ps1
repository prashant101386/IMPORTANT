$repoName = "${Env:reponame}"
$AccessToken = "${Env:keys}" 
$repoExisitFlag = "false"

# Set the headers including the authentication token
$headers = @{
  Authorization = "Bearer $AccessToken"
  "Content-Type" = "application/json"
  "User-Agent" = "Powershell-Script"
}

# Check if the repository already exists
$response = Invoke-RestMethod -Uri "https://api.github.com/repos/prashant101386/$repoName" -Headers $headers -Method Get -ErrorAction Stop

if ($response.name -eq $repoName) {
    Write-Host "Repository already exists."
}
else {
    # Create a new repository
    $repoData = @{
        name = $repoName
        description = $repoDescription
        auto_init = $true
    }

    $repoJson = $repoData | ConvertTo-Json

    $response = Invoke-RestMethod -Uri "https://api.github.com/user/repos" -Headers $headers -Method Post -Body $repoJson -ContentType "application/json"

    if ($response.StatusCode -eq 201) {
        Write-Host "Repository created successfully."
    }
    else {
        Write-Host "Error creating repository."
    }
}