$storageAccountName = "${Env:saname}"
$SaKey = "${keys}"
$filesystemName = "${Env:fsname}"
$userId = "${Env:user}"

$ctx = New-AzStorageContext -StorageAccountName $storageAccountName -StorageAccountKey $SaKey
$acl = set-AzDataLakeGen2ItemAclObject -AccessControlType user -EntityId $userId -Permission r--
Update-AzDataLakeGen2Item -Context $ctx -FileSystem $filesystemName -Acl $acl
$filesystem = Get-AzDataLakeGen2Item -Context $ctx -FileSystem $filesystemName
$filesystem.ACL