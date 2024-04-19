param($Context)

function Get-Names {
    $names = [char[]]('a'..'z') + [char[]]('A'..'Z')
    return $names
}

$output = Get-Names
$output
# Push-OutputBinding -Name Response -Value $output
