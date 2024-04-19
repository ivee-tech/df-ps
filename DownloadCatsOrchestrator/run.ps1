param($Context)

$output = @()
<#

$output += Invoke-DurableActivity -FunctionName 'Hello' -Input 'Tokyo'
$output += Invoke-DurableActivity -FunctionName 'Hello' -Input 'Seattle'
$output += Invoke-DurableActivity -FunctionName 'Hello' -Input 'London'

#>

# Call the Get-Names activity
# $names = Invoke-DurableActivity -FunctionName 'GetNames' -Input $Context
# $names | ForEach-Object {
#     $output += Invoke-DurableActivity -FunctionName 'Hello' -Input $_
# }

$cats = Invoke-DurableActivity -FunctionName 'GetCats' -Input $Context
# $cats | ForEach-Object -Parallel {
#     # $filePath = Invoke-DurableActivity -FunctionName 'Download' -Input $_.url
#     # $output += Invoke-DurableActivity -FunctionName 'SaveFileAsBlob' -Input $filePath
#     Invoke-DurableActivity -FunctionName 'DownloadAndSaveFileAsBlob' -Input $_.url
# }

$parallelTasks = $cats | ForEach-Object {
    Start-NewOrchestration -FunctionName 'DownloadAndSaveFileAsBlob' -Input $_.url
}

$taskResults = Wait-OrchestrationTask -Task $parallelTasks -All

# Return the result
# $output
