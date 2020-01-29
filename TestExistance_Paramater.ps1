function Test-HiveExistance {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$TRUE)]
        [ValidateSet("HKEY_USERS","HKEY_CURRENT_USER","HKEY_CURRENT_CONFIG")]
        [string]
        $Type
    )
    $ValueCheck = Get-PSDrive -PSProvider Registry
    $n = 1
    do {
        [string]$Name = "Hive"+$n
        New-PSDrive -Name $Name -PSProvider Registry -Root $Type -Scope Global
        $ValueCheck = Get-PSDrive -PSProvider Registry
        $n++
    } until (($ValueCheck.Root -like "$Type" -and $ValueCheck.Name -ne $Name) -or $n -lt 4)
}
#Added Global Scope as drive was not available after the test function. 
#Persist parameter only works on Remote FileSystems.