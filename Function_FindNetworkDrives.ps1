function Find-NetworkDrives {
    [CmdletBinding()]
    param (
        [Parameter(Position=1)]
        [string]
        $Identity,

        [Parameter()]
        [ValidateSet("Domain","Local")]
        [string]
        $Type,

        #For local function, the computer running the device will suffice. Computer name can be specified otherwise.
        [Parameter()]
        [string]
        $Computer=$env:COMPUTERNAME
    )
    Begin
    {
        #Import functions
        . '.\Functions - Testing\TestHiveExistance.ps1'
        . '.\Functions - Testing\TestModuleReady.ps1'
        . '.\Functions - Testing\TestDomainConnection.ps1'
        . '.\Functions - Type\Type_Domain.ps1'
        . '.\Functions - Type\Type_Local.ps1'
        #Variable Definitions:
        $Error.Clear()
        $WorkingFolder = $PWD
        $HKU = (Test-HiveExistance HKEY_USERS).Name

        switch ($Type){
            "Domain" {#Test Module Validity and Domain Connectivity:
                if((Test-ModuleReady -and Test-DomainConnectivity) -eq $true) {
                    $Location = Set-TypeDomain -Identity $Identity -PsDrive $HKU
                } else {Write-Host "RSAT is not installed on this machine, or there is no connection to the DC"; break}
            }
            "Local" {
                $Location = Set-TypeLocal -Identity $Identity -PsDrive $HKU
            }
        }
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