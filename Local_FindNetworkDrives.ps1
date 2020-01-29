#Import functions
. .\TestExistance.ps1 
#Local Test
$WorkingFolder = $PWD
#Test for HiveDrive, and create if missing:
Test-Existance
#Define the username:
$person = 'jack.neville'
#Navigate to the hive location:
[string]$Sid = (Get-ADUser -Identity $person).sid
[string]$location = "HKU:\" + $Sid + "\Network"
Set-Location $location
#List the network drive letters and targets:
Get-ItemProperty * | Format-Table pschildname,remotepath
Set-Location $WorkingFolder