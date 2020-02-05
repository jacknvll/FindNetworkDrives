function Set-TypeLocal {
    [CmdletBinding()]
    param (
        [Parameter(Position=0)]
        [string]
        $Identity,

        [Parameter()]
        [string]
        $PsDrive
    )
    #Testing the validity of variables Identity and Location:
    try {
        [string]$Sid = (Get-LocalUser -Name $Identity).SID
        [string]$Location = $PsDrive + ":\" + $Sid + "\Network"
        return $Location
    }
    catch {
        Write-Host "$Identity is not a local user"
        break
    }
}