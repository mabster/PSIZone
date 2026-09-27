function Invoke-IzCommand {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [string]$Command,
        [Parameter(Mandatory = $false)]
        [hashtable]$Body
    )

    if (!$Script:IZConnection) {
        Write-Error "Not connected to an IZ device. Please run Connect-IzDevice first."
        return
    }

    $uri = "http://$($Script:IZConnection.IPAddress)/$Command"
    if ($Body) {
        $ip = $Script:IZConnection.IPAddress   # Just the raw IP (e.g., "192.168.1.50")
        $port = 80             # Standard HTTP port
        $bodyJson = $Body | ConvertTo-Json -Compress

        $httpRequest = "POST /$Command HTTP/1.1`r`n" +
                       "Host: $ip`r`n" +
                       "Content-Type: application/json`r`n" +
                       "Content-Length: $($bodyJson.Length)`r`n" +
                       "Connection: close`r`n" + 
                       "`r`n" + # The mandatory blank line separating headers from body
                       $bodyJson

        $bytes = [System.Text.Encoding]::ASCII.GetBytes($httpRequest)
        try {
            $tcpClient = New-Object System.Net.Sockets.TcpClient($ip, $port)
            try {
                $stream = $tcpClient.GetStream()
                try {
                    $stream.Write($bytes, 0, $bytes.Length)
                    $stream.Flush()

                    $reader = New-Object System.IO.StreamReader($stream)
                    try {
                        $response = $reader.ReadToEnd()
                        if ($response -match "HTTP/1.1 200 OK") {
                            Write-Verbose "Command '$Command' executed successfully."
                        }
                        else {
                            Write-Error "Command '$Command' failed. Response: $response"
                        }
                    }
                    finally {
                        $reader.Close()
                    }
                }
                finally {
                    $stream.Close()
                }
            }
            finally {

                $tcpClient.Close()
            }
        }
        catch {
            Write-Error "TCP Socket Failure: $_"
        }
    }
    else {
        Invoke-RestMethod -Uri $uri -Method Get -ErrorAction Stop
    }
}