function Set-IzMode {
    [CmdletBinding()]
    param(
        [ValidateSet("cool", "heat", "vent", "dry", "auto")][string]$Mode
    )

    if (!$Script:IZConnection) {
        Write-Error "Not connected to an IZone. Use Connect-Iz to connect first."
        return
    }

    $body = @{ SystemMODE = $Mode }
    Invoke-IzCommand -Command "SystemMODE" -Body $body
}