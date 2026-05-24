#To validate ActiveDirectory on your machine.

function Test-ModuleReady {
    $Test = Test-Path 'C:\Windows\System32\WindowsPowerShell\v1.0\Modules\activedirectory'
    switch ($Test) {
        $true {try {Import-Module ActiveDirectory
            return $true}
    catch {return $false; Write-Host "Error importing the module ActiveDirectory."}}
        $false {return $false}
    }
}