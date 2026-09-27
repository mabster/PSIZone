function Get-IzStatus {
    if (!$Script:IZConnection) {
        Write-Error "Not connected to an IZone. Use Connect-Iz to connect first."
        return
    }
    return Invoke-IzCommand -Command "SystemSettings"
}
