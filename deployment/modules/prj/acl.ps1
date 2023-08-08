# Parameter for holding storage account access key passed from container-acl.bicep as argument.
param (
    [string] $keys,
    [string] $users
)

# Storage account name passed as environment variable.
$storageAccountName = "${Env:saname}"
# Filesystem name or container name passed as environment variable
$filesystemName = "${Env:fsname}"
# User
#$users = $users | ConvertFrom-Json
#$users = $users.TrimStart('[')
Out-File -FilePath .\output.txt -InputObject $users
$usersArray = $users -split ' '
Out-File -FilePath .\output1.txt -InputObject $usersArray
$users = $usersArray.TrimStart('[')
$users = $users.TrimEnd(']')
Out-File -FilePath .\output2.txt -InputObject $users
#$user = "${Env:users}"
$key = $keys
$ctx = New-AzStorageContext -StorageAccountName $storageAccountName -StorageAccountKey $key
foreach ($usr in $usersArray) {
    $acl = (Get-AzDataLakeGen2Item -Context $ctx -FileSystem $filesystemName).ACL
    $acl = set-AzDataLakeGen2ItemAclObject -AccessControlType user -EntityID $usr -Permission r-x -InputObject $acl
    Update-AzDataLakeGen2Item -Context $ctx -FileSystem $filesystemName -Acl $acl
}