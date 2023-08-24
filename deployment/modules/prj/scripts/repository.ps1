$repoName = "${Env:reponame}"
$AccessToken = "${Env:keys}" 
$repoExisitFlag = "false"

# Set the headers including the authentication token
$headers = @{
  Authorization = "Bearer $AccessToken"
  "Content-Type" = "application/json"
}
$repositoryApiUrl = "https://api.github.com/prashant101386"

# checking repository already available.
Invoke-RestMethod -Uri $repositoryApiUrl -Headers $headers -Method Get -SkipHttpErrorCheck -StatusCodeVariable 'statusCode'

Write-Host "Repository check : $statusCode"
if (($statusCode -eq 200)){ 
  $repoExisitFlag = "true"
}
else{

  $body = @{
  name = $repoName
  auto_init = $true
  } | ConvertTo-Json

  # Make the POST request to create the repository
  Invoke-RestMethod -Uri $repositoryApiUrl -Method POST -Headers $headers -Body $body
  $repoExisitFlag = "true"
}
if ($repoExisitFlag)
{
  # Can add other tasks after that repository created in this block. Currently skipping..
  
}