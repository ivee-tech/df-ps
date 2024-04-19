param($url)

$tempPath = (Get-Item Env:TEMP).Value
$uri = New-Object System.Uri($url)
$fileName = [System.IO.Path]::GetFileName($uri.LocalPath)
$destinationPath = [System.IO.Path]::Combine($tempPath, $fileName)
# Invoke-WebRequest -Uri $url -OutFile $destinationPath
$httpClient = New-Object System.Net.Http.HttpClient
$response = $httpClient.GetAsync($url).Result

if ($response.IsSuccessStatusCode) {
    $stream = $response.Content.ReadAsStreamAsync().Result
    $fileStream = [System.IO.File]::Create($destinationPath)
    $stream.CopyTo($fileStream)
    $fileStream.Close()
} else {
    Write-Error "HTTP request failed with status code: $($response.StatusCode)"
}

$filePath = $destinationPath

# # Define your storage account and container details
# $storageAccountName = "azfuncquickstartdr"
# $storageAccountKey = "***"
# $containerName = "cats"
# $blobName = Split-Path -Path $filePath -Leaf

# # Create a storage context
# $context = New-AzStorageContext -StorageAccountName $storageAccountName -StorageAccountKey $storageAccountKey 

# # Upload the file to blob storage
# Set-AzStorageBlobContent -File $filePath -Container $containerName -Blob $blobName -Context $context

# # Return the blob URL
# $blobUrl = "https://$storageAccountName.blob.core.windows.net/$containerName/$blobName"

$fileContent = Get-Content -Path $filePath -Raw

# Send the file content to a Blob output binding
Push-OutputBinding -Name OutputBlob -Value $fileContent
# return $blobUrl
# Push-OutputBinding -Name Response -Value $blobUrl