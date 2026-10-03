function Enable-IzSleepTimer {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [ValidateRange(1, 120)]
        [int]$SleepTimer
    )

    Set-IzSleepTimer -SleepTimer $SleepTimer
}