function Stop-Iz {
    if (!$Script:IZConnection) {
        Write-Error "Not connected to an IZone. Use Connect-Iz to connect first."
        return
    }

    $body = @{ SystemON = 'off' }
    Invoke-IzCommand -Command "SystemON" -Body $body
}
