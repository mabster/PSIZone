function Disable-IzSleepTimer {
    [CmdletBinding()]
    param()

    Set-IzSleepTimer -SleepTimer 0
}