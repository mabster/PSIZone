# Dot source public/private functions
$PrivateFunctions = @(Get-ChildItem -Path "$PSScriptRoot\private" -Filter *.ps1 -Recurse -ErrorAction SilentlyContinue)
$PublicFunctions = @(Get-ChildItem -Path "$PSScriptRoot\public" -Filter *.ps1 -Recurse -ErrorAction SilentlyContinue)

foreach ($f in $PrivateFunctions + $PublicFunctions) {
    . $f.FullName
}

# Create aliases for functions
$aliases = @{
    'ciz' = 'Connect-Iz'
    'gizs' = 'Get-IzStatus'
    'Set-IzTemperature' = 'Set-IzSetpoint'
    'Get-IzTemperature' = 'Get-IzSetPoint'
}
write-host $aliases.keys

foreach ($a in $aliases.Keys) {
    if (-not (Get-Command $a -ErrorAction SilentlyContinue)) {
        New-Alias -Name $a -Value $aliases.$a
    }
}

Export-ModuleMember -Function $PublicFunctions.BaseName -Alias '*' 