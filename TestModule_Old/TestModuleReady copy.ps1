#To validate ActiveDirectory on your machine.

function Test-ModuleReady {
    $Test = Test-Path 'C:\Windows\System32\WindowsPowerShell\v1.0\Modules\activedirectory'
    switch ($Test) {
        $true {try {Import-Module ActiveDirectory; Write-Warning -Message "Importing ActiveDirectory module."
        Write-Host "Module ready" -ForegroundColor Green}
    catch {Write-Host "Error importing the module ActiveDirectory."}}
        $false {Write-Host "Error: ActiveDirectory module not found on computer. Install the RSAT Tools for your OS version and try again."}
    }
}