function Get-IzZone {
    [CmdletBinding()]
    param(
       [ValidateRange(1, 12)][int]$Zone
    )
    if (!$Script:IZConnection) {
        Write-Error "Not connected to an IZone. Use Connect-Iz to connect first."
        return
    }

    if (!$PSBoundParameters['Zone']) {
        'Zones1_4','Zones5_8','Zones9_12' | ForEach-Object {
            Invoke-IzCommand -Command $_
        }
        return
    }

    switch ($Zone) {
        {$_ -in 1..4} { $zoneUri = "Zones1_4" }
        {$_ -in 5..8} { $zoneUri = "Zones5_8" }
        {$_ -in 9..12} { $zoneUri = "Zones9_12" }
        default {
            Write-Error "Invalid zone number. Zone must be between 1 and 12."
            return
        }
    }
    $response = Invoke-IzCommand -Command $zoneUri
    $response | Where-Object { $_.Index -eq ($Zone - 1) }
}