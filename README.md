# iZone for PowerShell

This is a work-in-progress PowerShell module to control your iZone air conditioner on your local network.

Just supporting the [older API version](https://developer.izone.com.au/downloads/iZoneEthernetInterface.v1.pdf) now, since that's the version my AC runs. If you have a more recent controller and would like to help build support for the newer API version, please send a pull request!

## Installation

Not published to the PowerShell Gallery just yet. To install, clone this repo, change into the IZone folder and run:

```PowerShell
Import-Module .\IZone.psm1
```

### Usage

We use the built-in UDP discovery to determine the IP address of your iZone controller. You can always pass an IP address to `Connect-Iz` if you know it.

You can use `Get-IzStatus` to check the status of your device.

```PowerShell
Connect-Iz
Get-IzStatus
Disconnect-Iz
```

There's no real reason to disconnect - it just clears some in-memory values to "forget" the IP address.

### AI Disclaimer

This module was predominantly hand-written, but I did ask for Gemini's help to write the UDP discovery code, and to determine why Invoke-RestMethod would not POST to the controller and subsequently rewrite it as a bare-metal HTTP call.