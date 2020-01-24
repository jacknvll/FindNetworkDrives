#This is a small script to test if PSDrive exists.
#If it does exist, do not create.
#If it doesn't exist, create.

#Value 1 is a known mapped PsDrive, and Value 2 does not exist by default:
$Value1 = Get-PSDrive | Where-Object {$_.root -like "HKEY_CURRENT_USER"}
$Value2 = Get-PSDrive | Where-Object {$_.root -like "HKEY_USERS"}
if ($Value1) 
    {Write-Host "PsDrive exists"} else 
    {Write-Host "PsDrive does not exist"}
if ($Value2) 
    {Write-Host "PsDrive exists"} else 
    {Write-Host "PsDrive does not exist"}
#Testing is successful.