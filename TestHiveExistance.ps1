function Test-HiveExistance {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$TRUE)]
        [ValidateSet("HKEY_USERS","HKEY_CLASSES_ROOT","HKEY_CURRENT_CONFIG")]
        [string]
        $Type
    )
    $Error.Clear()
    $ValueCheck = Get-PSDrive -PSProvider Registry | Where-Object {$_.root -like $Type} #There can only be one.
    if (!$ValueCheck){
        $n = 1
        do {
            [string]$Name = "Hive"+$n
            try {[void](New-PSDrive -Name $Name -PSProvider Registry -Root $Type -Scope Global -ErrorAction Stop)}
            catch [System.Management.Automation.SessionStateException] {$n++}
            $ValueCheck = Get-PSDrive -PSProvider Registry | Where-Object {$_.root -like $Type}    
        } while ($ValueCheck.Root -notlike "$Type" -and $ValueCheck.Name -notlike "$Name")
    $Final = Get-PSDrive -Name $Name
    return $Final
    } else {
        return $ValueCheck
    }
    
}