function Enable-IzSchedule {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [ValidateRange(1, 9)]
        [int]$Schedule
    )

    if (!$Script:IZConnection) {
        Write-Error "Not connected to an IZone. Use Connect-Iz to connect first."
        return
    }

    $body = @{ ScheduleCommand = @{ SchedNo = $Schedule; Command = 'on' } }
    Invoke-IzCommand -Command "ScheduleCommand" -Body $body
}