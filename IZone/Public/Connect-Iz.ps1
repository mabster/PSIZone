function Connect-Iz {
    [CmdletBinding()]
    param(
        [Parameter(ParameterSetName = 'Manual', Mandatory = $true)]
        [string]$IPAddress,

        [Parameter(ParameterSetName = 'Automatic')]
        [timespan]$Timeout = [timespan]::FromSeconds(2)
    )

    if (!$IPAddress) {
        $u = [System.Net.Sockets.UdpClient]::new() 
        $u.EnableBroadcast = $true
        $u.Client.ReceiveTimeout = $Timeout.TotalMilliseconds
        $ep = [System.Net.IPEndPoint]::new([System.Net.IPAddress]::Broadcast, 12107) 
        $b = [System.Text.Encoding]::ASCII.GetBytes('IASD')
        $u.Send($b, $b.Length, $ep) | Out-Null 
        try { 
            $rep = [System.Net.IPEndPoint]::new([System.Net.IPAddress]::Any, 0); 
            $rb = $u.Receive([ref]$rep);
            $response = [System.Text.Encoding]::ASCII.GetString($rb)
            
            Write-Verbose "IZone discovery response: $response"
            $responses = $response -split ',' 
            $IPAddress = $responses | Where-Object { $_ -like 'IP_*' } | ForEach-Object { $_ -split '_' } | Select-Object -Last 1

            if (!$IPAddress) {
                Write-Error 'IZone discovery did not return an IP address. Specify an IP address to connect manually.'
                return
            }
        } 
        catch
        { 
            Write-Error 'IZone discovery failed. Specify an IP address to connect manually.'
        }
        finally { 
            $u.Close() 
        }
    }

    try {
        $response = Invoke-RestMethod -Uri "http://$IPAddress/SystemSettings" -ErrorAction Stop
        $Script:IZConnection = [PSCustomObject]@{
            IPAddress = $IPAddress
            Id = $response.AirStreamDeviceUId
        }
        Write-Verbose $Script:IZConnection
    }
    catch {
        Write-Error "Failed to connect to IZone at $IPAddress. Specify a different IP address to connect manually."
    }
}