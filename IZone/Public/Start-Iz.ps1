function Start-Iz {
    if (!$Script:IZConnection) {
        Write-Error "Not connected to an IZone. Use Connect-Iz to connect first."
        return
    }

    # Invoke-Restmethod -Uri "http://$($Script:IZConnection.IPAddress)/SystemON" -Method Post -Body '{ "SystemON" : "on" }' -ContentType "application/json" -ErrorAction Stop
    $body = @{ SystemON = 'on' }
    Invoke-IzCommand -Command "SystemON" -Body $body
}
