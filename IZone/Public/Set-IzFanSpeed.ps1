function Set-IzFanSpeed {
    [CmdletBinding()]
    param(
        [ValidateSet("low", "medium", "high", "auto")][string]$FanSpeed
    )

    if (!$Script:IZConnection) {
        Write-Error "Not connected to an IZone. Use Connect-Iz to connect first."
        return
    }

    $body = @{ SystemFAN = $FanSpeed }
    Invoke-IzCommand -Command "SystemFAN" -Body $body
}