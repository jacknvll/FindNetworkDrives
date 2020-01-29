function Test-HiveExistance {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$TRUE)]
        [ValidateSet("HKEY_USERS","HKEY_CLASSES_ROOT","HKEY_CURRENT_CONFIG")]
        [string]
        $Type
    )
    $Error.Clear()
    $ValueCheck = Get-PSDrive -PSProvider Registry | Where-Object {$_.root -like $Type} # -or $_.Name -like "Hive1"
    if ($ValueCheck.root -notlike "$Type"){
        $n = 1
        do {
            [string]$Name = "Hive"+$n
            try {New-PSDrive -Name $Name -PSProvider Registry -Root $Type -Scope Global -ErrorAction Stop}
            catch [System.Management.Automation.SessionStateException] {$n++}
            $ValueCheck = Get-PSDrive -PSProvider Registry | Where-Object {$_.root -like $Type}    
        } while ($ValueCheck.Root -notlike "$Type" -and $ValueCheck.Name -notlike "$Name")
    } else {
        Write-Host "$Type already exists with the name $($ValueCheck.Name)"
    }
}