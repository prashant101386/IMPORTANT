# Parameter for holding storage account access key passed from container-acl.bicep as argument.
param (
    [string] $keys,
    [string[]] $users
)

# Storage account name passed as environment variable.
$storageAccountName = "${Env:saname}"
# Filesystem name or container name passed as environment variable
$filesystemName = "${Env:fsname}"
# User
$usersArray = $users -split ','
#$user = "${Env:users}"
$key = $keys
$ctx = New-AzStorageContext -StorageAccountName $storageAccountName -StorageAccountKey $key
foreach ($usr in $usersArray) {
    $acl = (Get-AzDataLakeGen2Item -Context $ctx -FileSystem $filesystemName).ACL
    $acl = set-AzDataLakeGen2ItemAclObject -AccessControlType user -EntityID $usr -Permission r-x -InputObject $acl
    Update-AzDataLakeGen2Item -Context $ctx -FileSystem $filesystemName -Acl $acl
}