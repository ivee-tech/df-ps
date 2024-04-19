param($Context)

function Get-Cats($n, $limit) {
    $cats = @()
    for($i = 0; $i -lt $n; $i++) {
        # $url = "https://api.thecatapi.com/v1/images/search?limit=$limit"
        # $result = Invoke-RestMethod -Uri $url
        $httpClient = New-Object System.Net.Http.HttpClient
        $url = "https://api.thecatapi.com/v1/images/search?limit=$limit"
        $result = $httpClient.GetAsync($url).Result.Content.ReadAsStringAsync().Result | ConvertFrom-Json
        $cats += $result
    }
    return $cats
}

$output = Get-Cats -n 10 -limit 10
return $output
# Push-OutputBinding -Name Response -Value $output
