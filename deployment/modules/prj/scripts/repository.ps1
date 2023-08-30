$repoName = "${Env:reponame}"
$AccessToken = "${Env:keys}" 
$repoExisitFlag = "false"

# Set the headers including the authentication token
$headers = @{
  Authorization = "Bearer $AccessToken"
  "Content-Type" = "application/json"
  "User-Agent" = "Powershell-Script"
}
$repositoryApiUrl = "https://api.github.com/user/repos"

# checking repository already available.
$statusCode = Invoke-RestMethod -Uri $repositoryApiUrl -Headers $headers -Method Get -SkipHttpErrorCheck -StatusCodeVariable 'statusCode'

Write-Host "Repository check : $statusCode"
if (($statusCode -eq 200)){ 
  $repoExisitFlag = "true"
  Exit
}
else {

  $body = @{
  name = $repoName
  auto_init = true
  private = true
  } | ConvertTo-Json

  # Make the POST request to create the repository
  Invoke-RestMethod -Uri $repositoryApiUrl -Method POST -Headers $headers -Body $body
  $repoExisitFlag = "true"
}