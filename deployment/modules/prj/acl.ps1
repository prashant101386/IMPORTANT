$storageAccountName = "${Env:saname}"
$StorageAccountKey = "${keys}"
$filesystemName = "${Env:fsname}"
$userId = "${Env:user}"
$secret = Get-AzKeyVaultSecret -VaultName "dmw2dihadbkv01-learning" -Name "SAKey" -AsPlainText

$ctx = New-AzStorageContext -StorageAccountName $storageAccountName -StorageAccountKey $secret
$acl = set-AzDataLakeGen2ItemAclObject -AccessControlType user -EntityId $userId -Permission r--
Update-AzDataLakeGen2Item -Context $ctx -FileSystem $filesystemName -Acl $acl
$filesystem = Get-AzDataLakeGen2Item -Context $ctx -FileSystem $filesystemName
$filesystem.ACL