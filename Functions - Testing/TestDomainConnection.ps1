#Test you have a stable connection to the DC when searching for a domain account.
function Test-DomainConnectivity
{
[CmdletBinding()]
    param (
        [Parameter(Mandatory=$TRUE)]
        [string]
        $DomainFQDN
    )
    try {
        $Connectivity = (Test-Connection $DomainFQDN -Count 4 -ErrorAction SilentlyContinue | Measure-Object).Count
    }
    catch {Continue}

    if ($Connectivity -eq 4){return $true}
    else {return $false}
}
