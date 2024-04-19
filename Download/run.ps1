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

return $destinationPath
# Push-OutputBinding -Name Response -Value $destinationPath
