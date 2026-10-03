function Set-IzSleepTimer {
    [CmdletBinding()]
    param(
        # The number of minutes to set the sleep timer for (0 to turn it off)
        [Parameter(Mandatory=$true)]
        [ValidateRange(0, 120)]
        [int]$SleepTimer
    )

    if (!$Script:IZConnection) {
        Write-Error "Not connected to an IZone. Use Connect-Iz to connect first."
        return
    }

    $body = @{ SleepTimer = $SleepTimer }
    Invoke-IzCommand -Command "SleepTimer" -Body $body
}
