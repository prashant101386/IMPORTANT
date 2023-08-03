# Parameter for holding storage account access key passed from container-acl.bicep as argument.
param ([string] $keys)

# Storage account name passed as environment variable.
$storageAccountName = "${Env:saname}"
# Filesystem name or container name passed as environment variable
$filesystemName = "${Env:fsname}"
# User
$user = "${Env:users}"
$key = $keys
$ctx = New-AzStorageContext -StorageAccountName $storageAccountName -StorageAccountKey $key
foreach ($usr in $user) {
$acl = set-AzDataLakeGen2ItemAclObject -AccessControlType user -EntityId $usr -Permission r--
Update-AzDataLakeGen2Item -Context $ctx -FileSystem $filesystemName -Acl $acl
$filesystem = Get-AzDataLakeGen2Item -Context $ctx -FileSystem $filesystemName
}
$filesystem.ACL