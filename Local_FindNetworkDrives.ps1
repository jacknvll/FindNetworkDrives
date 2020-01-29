#Import functions
. .\TestHiveExistance.ps1
Import-Module ActiveDirectory

#Potential Parameter/s:
#$person = 'jack.neville'

#Variable Definitions:
$Error.Clear()
$WorkingFolder = $PWD
$HKU = (Test-HiveExistance HKEY_USERS).Name
#[string]$Sid = (Get-ADUser -Identity $person).sid   --- replaced by $manual for testing
[string]$manual = 'S-1-5-21-3794749596-1985790629-174587685-144204' #SID of $person, for when im not on the network and to do testing.
[string]$location = $HKU + ":\" + $manual + "\Network"

#List the network drive letters and targets:
Set-Location $location
$Results = Get-ItemProperty * | Format-Table pschildname,remotepath

#Result and Return
Set-Location $WorkingFolder
Remove-PSDrive $HKU
return $Results