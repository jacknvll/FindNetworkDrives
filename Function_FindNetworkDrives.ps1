function Find-NetworkDrives {
    [CmdletBinding()]
    param (
        [Parameter(Position=1)]
        [string]
        $Identity,

        #For local function, the computer running the device will suffice. Computer name can be specified otherwise.
        [Parameter()]
        [string]
        $Computer=$env:COMPUTERNAME,

        # Domain Fully Qualified Domain Name
        [Parameter()]
        [string]
        $DomainFQDN
    )
    Begin
    {
        #Import functions
        . '.\Functions\TestHiveExistance.ps1'
        . '.\Functions\TestModuleReady.ps1'
        . '.\Functions\TestDomainConnection.ps1'
        #Variable Definitions:
        $Error.Clear()
        $WorkingFolder = $PWD
        $HKU = (Test-HiveExistance HKEY_USERS).Name
        #Test Module Validity and Domain Connectivity:
        $DomainTested = Test-DomainConnectivity -DomainFQDN $DomainFQDN
        if((Test-ModuleReady -and $DomainTested) -eq $true) {
            #Testing the validity of variables Identity and Location:
            try {
                [string]$Sid = (Get-ADUser -Identity $Identity -ErrorAction SilentlyContinue).sid
                [string]$Location = $HKU + ":\" + $Sid + "\Network"
            }
            catch [Microsoft.ActiveDirectory.Management.ADIdentityNotFoundException] {
                Write-Host "$Identity is not a domain user"
                break
            }
        } else {Write-Host "RSAT is not installed on this machine, or there is no connection to the DC"; break}
    }
    Process
    {
        #List the network drive letters and targets:
        try{
            Set-Location $Location -ErrorAction Stop
            $Results = Get-ItemProperty * | Format-Table pschildname,remotepath
        }
        catch {
            Write-Host "Hive path does not exist. Process cancelled."; break
        }
    }
    End
    {
        Set-Location $WorkingFolder
        Remove-PSDrive $HKU
        return $Results
    }
}
