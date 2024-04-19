param($filePath)

# Import the required module
# Import-Module Az.Storage

# Define your storage account and container details
$storageAccountName = "azfuncquickstartdr"
$storageAccountKey = "***"
$containerName = "cats"
$blobName = Split-Path -Path $filePath -Leaf

# Create a storage context
$context = New-AzStorageContext -StorageAccountName $storageAccountName -StorageAccountKey $storageAccountKey 

# Upload the file to blob storage
Set-AzStorageBlobContent -File $filePath -Container $containerName -Blob $blobName -Context $context

# Return the blob URL
$blobUrl = "https://$storageAccountName.blob.core.windows.net/$containerName/$blobName"
return $blobUrl
# Push-OutputBinding -Name Response -Value $blobUrl