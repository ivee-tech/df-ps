# local
$url = "http://localhost:7071/api/orchestrators/DownloadCatsOrchestrator"

# cloud
$funcAppName = 'func-auea-dev-df001'
$url = "https://$funcAPpName.azurewebsites.net/api/orchestrators/DownloadCatsOrchestrator"

# local 2 C#
$url = 'http://localhost:7071/api/DownloadCatsOrchestrator_HttpStart'

# cloud 2 C#
$funcAppName = 'func-auea-dev-df002'
$url = "https://$funcAppName.azurewebsites.net/api/DownloadCatsOrchestrator_HttpStart"


$result = Invoke-RestMethod -Uri $url -Method Post
$statusUrl = $result.statusQueryGetUri
$historyPurgeUrl = $result.purgeHistoryDeleteUri

$statusResult = Invoke-RestMethod -Uri $statusUrl -Method Get
$statusResult

$historyPurgeResult = Invoke-RestMethod -Uri $historyPurgeUrl -Method Delete
$historyPurgeResult


Get-Module -Name Az -ListAvailable
Get-Module -Name Az.Storage -ListAvailable


func durable get-runtime-status --id <instance-id> --show-input true --show-output true
func durable get-instances


$tempPath = (Get-Item Env:TEMP).Value
$folderName = "cats"
$sourcePath = [System.IO.Path]::Combine($tempPath, $folderName)
$storageAccountName = "azfuncquickstartdr"
$containerName = "cats"
$sasToken = "***"
$destinationUrl = "https://$storageAccountName.blob.core.windows.net/$($containerName)?$sasToken"
azcopy copy "$sourcePath" "$destinationUrl" --recursive=true
