function Set-IzSetpoint {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [ValidateRange(16, 30)]
        [double]$SetPoint
    )

    if (!$Script:IZConnection) {
        Write-Error "Not connected to an IZone. Use Connect-Iz to connect first."
        return
    }

    $body = @{ UnitSetpoint = $Setpoint }
    Invoke-IzCommand -Command "UnitSetpoint" -Body $body
}