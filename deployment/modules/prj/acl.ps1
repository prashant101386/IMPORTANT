$storageAccountName = "${Env:saname}"
$filesystemName = "${Env:fsname}"
$userId = "${Env:user}"
$keys
$ctx = New-AzStorageContext -StorageAccountName 'dmw2dihadbsa01learning' -StorageAccountKey ${$keys}
$acl = set-AzDataLakeGen2ItemAclObject -AccessControlType user -EntityId $userId -Permission r--
Update-AzDataLakeGen2Item -Context $ctx -FileSystem $filesystemName -Acl $acl
$filesystem = Get-AzDataLakeGen2Item -Context $ctx -FileSystem $filesystemName
$filesystem.ACL