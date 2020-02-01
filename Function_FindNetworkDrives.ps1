function Find-NetworkDrives {
    [CmdletBinding()]
    param (
        [Parameter(Position=1)]
        [string]
        $Identity,

        #For local function, the computer running the device will suffice. Computer name can be specified otherwise.
        [Parameter()]
        [string]
        $Computer=$env:COMPUTERNAME
    )
    Begin
    {
        #Import functions
        . .\TestHiveExistance.ps1
        . .\TestModuleReady.ps1
        . .\TestDomainConnection.ps1
        #Variable Definitions:
        $Error.Clear()
        $WorkingFolder = $PWD
        $HKU = (Test-HiveExistance HKEY_USERS).Name
        #Test Module Validity and Domain Connectivity:
        if((Test-ModuleReady -and Test-DomainConnectivity) -eq $true) {
            #Testing the validity of variables Identity and Location:
            try {
                [string]$Sid = (Get-ADUser -Identity $Identity -ErrorAction SilentlyContinue).sid
                [string]$Location = $HKU + ":\" + $Sid + "\Network"
                if ((Test-Path $Location) -eq $false) {
                    Write-Host "Cannot find the path. Process cancelled."
                    Write-Host "$Location"; break}
            }
            catch {
                Write-Host "$Identity cannot be found in domain"
                break
            }
        } else {Write-Host "RSAT is not installed on this machine, or there is no connection to the DC"; break}
    }
    Process
    {
        #List the network drive letters and targets:
        Set-Location $Location
        $Results = Get-ItemProperty * | Format-Table pschildname,remotepath
    }
    End
    {
        #Result and Return
        Set-Location $WorkingFolder
        Remove-PSDrive $HKU
        return $Results
    }
}







