# Parameter for holding storage account access key passed from container-acl.bicep as argument.
param ([string] $keys)
# Storage account name passed as environment variable.
$storageAccountName = "${Env:saname}"
# Filesystem name or container name passed as environment variable
$filesystemName = "${Env:fsname}"
# User
$userId1 = "${Env:user1}"
$userId2 = "${Env:user2}"
$key = $keys
$ctx = New-AzStorageContext -StorageAccountName $storageAccountName -StorageAccountKey $key
$acl = set-AzDataLakeGen2ItemAclObject -AccessControlType user -EntityId $userId1 -Permission r--
$acl = set-AzDataLakeGen2ItemAclObject -AccessControlType user -EntityId $userId2 -Permission r--
Update-AzDataLakeGen2Item -Context $ctx -FileSystem $filesystemName -Acl $acl
$filesystem = Get-AzDataLakeGen2Item -Context $ctx -FileSystem $filesystemName
$filesystem.ACL