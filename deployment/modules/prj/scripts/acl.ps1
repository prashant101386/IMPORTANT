# Parameter for holding storage account access key passed from container-acl.bicep as argument.
param (
    [string] $users,
    [string] $user,
    [string] $upermission
)

# Storage account name passed as environment variable.
$storageAccountName = "${Env:saname}"
# Filesystem name or container name passed as environment variable
$filesystemName = "${Env:fsname}"

# User
#$users = $users | ConvertFrom-Json
#$users = $users.TrimStart('[')
#Out-File -FilePath .\output.txt -InputObject $users
#$usersArray = $users.Trim('[', ']').Split(' ')
#Out-File -FilePath .\output2.txt -InputObject $usersArray
#$user = "${Env:users}"
$key = ${Env:keys}
$ctx = New-AzStorageContext -StorageAccountName $storageAccountName -StorageAccountKey $key
#foreach ($userPermissionPair in $usersArray) {
#    $user, $upermission = $userPermissionPair -split ':'
    $acl = (Get-AzDataLakeGen2Item -Context $ctx -FileSystem $filesystemName).ACL
    $acl = set-AzDataLakeGen2ItemAclObject -AccessControlType user -EntityID $user -Permission $upermission -InputObject $acl
    Update-AzDataLakeGen2Item -Context $ctx -FileSystem $filesystemName -Acl $acl
}