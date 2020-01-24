#Local Test
#Define the username:
$person = 'jack.neville'
#Create Hive Drive:
New-PSDrive HKU Registry HKEY_USERS
#Navigate to the hive location:
[string]$Sid = (Get-ADUser -Identity $person).sid
[string]$location = "HKU:\" + $Sid + "\Network"
Set-Location $location
#List the network drive letters and targets:
Get-ItemProperty * | Select-Object pschildname,remotepath
