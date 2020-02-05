function Set-TypeDomain {
    [CmdletBinding()]
    param (
        [Parameter()]
        [string]
        $Identity,

        [Parameter()]
        [string]
        $PsDrive
    )
    #Testing the validity of variables Identity and Location:
    try {
        [string]$Sid = (Get-ADUser -Identity $Identity -ErrorAction SilentlyContinue).sid
        [string]$Location = $PsDrive + ":\" + $Sid + "\Network"
        return $Location
    }
    catch [Microsoft.ActiveDirectory.Management.ADIdentityNotFoundException] {
        Write-Host "$Identity is not a domain user"
        break
    }
}