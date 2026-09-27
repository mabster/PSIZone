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

function Enable-SleepTimer {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [ValidateRange(1, 120)]
        [int]$SleepTimer
    )

    Set-IzSleepTimer -SleepTimer $SleepTimer
}

function Disable-SleepTimer {
    [CmdletBinding()]
    param()

    Set-IzSleepTimer -SleepTimer 0
}