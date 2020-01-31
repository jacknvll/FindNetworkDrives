#This is a small script to test if PSDrive exists.
#If it does exist, do not create.
#If it doesn't exist, create.
#Value 1 is a known mapped PsDrive, and Value 2 does not exist by default:
#$Value1 = Get-PSDrive | Where-Object {$_.root -like "HKEY_CURRENT_USER"}
<#if ($Value1) 
    {Write-Host "PsDrive exists"} else 
    {Write-Host "PsDrive does not exist"}
if ($Value2) 
    {Write-Host "PsDrive exists"} else 
    {Write-Host "PsDrive does not exist"}
#Testing is successful.
#>
<#
function Test-Existance {
    $ValueCheck = Get-PSDrive | Where-Object {$_.root -like "HKEY_USERS"}
        if ($ValueCheck.Root) {return 'exists'}
        else {
            New-PSDrive HKU Registry HKEY_USERS
            return 'created'
        }
}
#>
function Test-Existance {
    $ValueCheck = Get-PSDrive | Where-Object {$_.root -like "HKEY_USERS"}
    do {
        New-PSDrive HKU Registry HKEY_USERS -Scope Global
        $ValueCheck = Get-PSDrive | Where-Object {$_.root -like "HKEY_USERS"}
    } until ($ValueCheck.Root -like "HKEY_USERS")
}
#Added Global Scope as drive was not available after the test function. 
#Persist parameter only works on Remote FileSystems.