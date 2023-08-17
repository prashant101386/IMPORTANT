# Storage account name passed as environment variable.
$storageAccountName = "${Env:saname}"
# Filesystem name or container name passed as environment variable
$filesystemName = "${Env:fsname}"

$key = ${Env:keys}
$ctx = New-AzStorageContext -StorageAccountName $storageAccountName -StorageAccountKey $key

Remove-AzStorageContainer -Name $filesystemName -Context $ctx