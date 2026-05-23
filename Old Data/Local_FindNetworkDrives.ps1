#Import functions
. .\TestHiveExistance.ps1
. .\TestModuleReady.ps1
if (Test-ModuleReady -eq $true){
    #Potential Parameter/s:
    $Person = ''

    #Variable Definitions:
    $Error.Clear()
    $WorkingFolder = $PWD
    $HKU = (Test-HiveExistance HKEY_USERS).Name
    [string]$Sid = (Get-ADUser -Identity $Person).sid
    [string]$Location = $HKU + ":\" + $Sid + "\Network"

    #List the network drive letters and targets:
    Set-Location $Location
    $Results = Get-ItemProperty * | Format-Table pschildname,remotepath

    #Result and Return
    Set-Location $WorkingFolder
    Remove-PSDrive $HKU
    return $Results
}
else {Write-Host "Error: ActiveDirectory module not found on computer. Install the RSAT Tools for your OS version and try again."}
