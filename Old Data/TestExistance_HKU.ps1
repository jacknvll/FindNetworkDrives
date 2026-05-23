#This is a small script to test if PSDrive exists.
#If it does exist, do not create.
#If it doesn't exist, create.

function Test-Existance {
    $ValueCheck = Get-PSDrive | Where-Object {$_.root -like "HKEY_USERS"}
    do {
        New-PSDrive HKU Registry HKEY_USERS -Scope Global
        $ValueCheck = Get-PSDrive | Where-Object {$_.root -like "HKEY_USERS"}
    } until ($ValueCheck.Root -like "HKEY_USERS")
}
#Added Global Scope as drive was not available after the test function. 
#Persist parameter only works on Remote FileSystems.
