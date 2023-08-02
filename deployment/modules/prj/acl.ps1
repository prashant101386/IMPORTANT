$storageAccountName = "${Env:saname}"
$StorageAccountKey = "${keys}"
$filesystemName = "${Env:fsname}"
$userId = "${Env:user}"

$ctx = New-AzStorageContext -StorageAccountName $storageAccountName -StorageAccountKey 'DsAWseTsUqtVx+zrdm/AylHJkFxK+hjq7etYoBg5skV/N3C69nh8X4DT+qlWlu3xv5tByc2CvUjB+AStKYkVLA=='
$acl = set-AzDataLakeGen2ItemAclObject -AccessControlType user -EntityId $userId -Permission r--
Update-AzDataLakeGen2Item -Context $ctx -FileSystem $filesystemName -Acl $acl
$filesystem = Get-AzDataLakeGen2Item -Context $ctx -FileSystem $filesystemName
$filesystem.ACL