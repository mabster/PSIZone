function Get-IzSchedule {
    [CmdletBinding()]
    param(
       [ValidateRange(1, 9)][int]$Schedule
    )
    if (!$Script:IZConnection) {
        Write-Error "Not connected to an IZone. Use Connect-Iz to connect first."
        return
    }

    if (!$PSBoundParameters['Schedule']) {
        'Schedules1_5','Schedules6_9' | ForEach-Object {
            Invoke-IzCommand -Command $_
        }
        return
    }

    switch ($Schedule) {
        {$_ -in 1..5} { $scheduleUri = "Schedules1_5" }
        {$_ -in 6..9} { $scheduleUri = "Schedules6_9" }
        default {
            Write-Error "Invalid schedule number. Schedule must be between 1 and 9."
            return
        }
    }
    $response = Invoke-IzCommand -Command $scheduleUri
    $response | Where-Object { $_.Index -eq ($Schedule - 1) }
}